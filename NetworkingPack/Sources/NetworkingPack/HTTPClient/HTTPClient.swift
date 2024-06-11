//
//  HTTPClient.swift
//
//
//  Created by Valeh Amirov on 04.06.24.
//

import Foundation

public final class HTTPClient {
    
    private init() {}
    public static let shared = HTTPClient()
    
    /// it is generic function which is  send request to API and return us information
    /// - Parameters:
    ///   - endPoint: gives developer the ability to choose which api to send a request to
    ///   - method: gives deveoper the ability to choose which type of request we want
    ///   - completion: returned generic type information and custom error type
    private func request<T: Decodable>(endPoint: String, method: HTTPMethod, body: Data?) async throws -> T? {
        guard let url = URL(string: endPoint) else {
            print(NetworkError.badUrl)
            throw NetworkError.badUrl
        }
        
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = 60
        
        
        if let requestBody = body {
            urlRequest.httpBody = requestBody
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        do {
            return try await checkStatus(response: response, data: data, urlRequest: urlRequest, method: method)
        }
        catch {
            try await self.checkError(error: error)
            throw error
        }
    }
    
    func checkError(error: Error?) async throws  {
        if let error {
            print(error)
            
            if let urlError = error as? URLError {
                if urlError.code == .timedOut {
                    throw NetworkError.timeOut
                } else if urlError.code == .badURL {
                    throw NetworkError.badUrl
                } else if urlError.code == .notConnectedToInternet {
                    throw NetworkError.noInternetConnection
                }
            }
        }
        throw NetworkError.unknowned
    }
    
    func checkStatus<T: Decodable>(response: URLResponse? , data: Data?, urlRequest: URLRequest, method: HTTPMethod) async throws -> T? {
        
        if let response = response as? HTTPURLResponse {
            guard response.statusCode == 200 else {
                do {
                    if let httpBody = urlRequest.httpBody {
                        print(try JSONSerialization.jsonObject(with: httpBody))
                    }
                    print("\(method.rawValue)", response)
                                        
                    guard let data = data else { throw NetworkError.badParsing }
                    if let result = String(data: data, encoding: .utf8) {
                        print(result)
                    }
                    
                    let errorDecode = try JSONDecoder().decode(ErrorModel.self, from: data)
                    
                    switch response.statusCode {
                    case 400:
                        throw NetworkError.badRequest(errorDecode.message)
                    case 401...403:
                        throw NetworkError.unauthorization
                    case 404:
                        throw NetworkError.notFound(errorDecode.message)
                    case 500:
                        throw NetworkError.unknowned
                    default:
                        throw NetworkError.statusError
                    }
                }
                catch {
                    print(error)
                }
                throw NetworkError.statusError
            }
            
            guard let data = data else { throw NetworkError.badParsing }
            
            do {
                let decode = try JSONDecoder().decode(T.self, from: data)
                return decode
            }
            catch {
                self.decodingError(error: error)
                throw NetworkError.badParsing
            }
        }
        throw NetworkError.statusError
    }
    
    /// When developer use decode and got error it will check developer's error
    private func decodingError(error: Error) {
        if let decodingError = error as? DecodingError {
            switch decodingError {
            case .dataCorrupted(let context):
                print("Data Corrupted: \(context)")
            case .keyNotFound(let key, let context):
                print("Key '\(key.stringValue)' not found:", context.debugDescription)
                print("CodingPath:", context.codingPath)
            case .typeMismatch(let type, let context):
                print("Type mismatch for type '\(type)',", context.debugDescription)
                print("CodingPath:", context.codingPath)
            case .valueNotFound(let type, let context):
                print("Value not found for type '\(type)',", context.debugDescription)
                print("CodingPath:", context.codingPath)
            default:
                print("Decoding error:", error)
            }
        } else {
            print("Decoding error:", error)
        }
    }
}
extension HTTPClient {
    
    public func GET<T: Decodable>(endPoint: String) async throws -> T?  {
        do {
            return try await request(endPoint: endPoint, method: .GET, body: nil)
        }
        catch {
            throw error
        }
    }
}
