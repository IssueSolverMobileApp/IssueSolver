//
//  HTTPClient.swift
//  
//
//  Created by Valeh Amirov on 13.06.24.
//

import Foundation

public protocol AuthTriggerProtocol: AnyObject {
    func accessTokenTrigger(isActive: Bool)
}

public final class HTTPClient {
    
    private init() {}
    public static let shared = HTTPClient()
    
    public weak var deletage: AuthTriggerProtocol?
        
    let header: [String: String] = ["accept": "*/*", "Content-Type": "application/json"]
    
    /// it is generic function which is  send request to API and return us information
    /// - Parameters:
    ///   - endPoint: gives developer the ability to choose which api to send a request to
    ///   - method: gives deveoper the ability to choose which type of request we want
    ///   - completion: returned generic type information and custom error type
    private func request<T: Decodable>(endPoint: EndPoint, method: HTTPMethod, body: Data?, completion: @escaping(T?, Error?) -> Void) {
        guard var url = URLComponents(string: endPoint.url) else {
            print(NetworkError.badUrl)
            completion(nil, NetworkError.badUrl)
            return
        }
        
        setQueryItem(url: &url)

        guard let url = url.url else { completion(nil, NetworkError.badUrl); return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        header.forEach { (key: String, value: String) in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        urlRequest.timeoutInterval = 60
        
        if let requestBody = body {
            urlRequest.httpBody = requestBody
        }
        setAccessToken(urlRequest: &urlRequest)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            self.checkError(error: error, completion: completion)
            self.checkStatus(endPoint: endPoint, response: response, data: data, urlRequest: urlRequest, method: method, completion: completion)
            return
        }.resume()
    }
    
    func checkError<T: Decodable>(error: Error?, completion: @escaping(T?, Error?) -> Void){
        if let error {
            print(error)
            
            if let urlError = error as? URLError {
                if urlError.code == .timedOut {
                    completion(nil, NetworkError.timeOut)
                } else if urlError.code == .badURL {
                    completion(nil, NetworkError.badUrl)
                } else if urlError.code == .notConnectedToInternet {
                    completion(nil, NetworkError.noInternetConnection)
                }
            }
            return
        }
    }
    
    
    func checkStatus<T: Decodable>(endPoint: EndPoint, response: URLResponse? , data: Data?, urlRequest: URLRequest, method: HTTPMethod, completion: @escaping(T?, Error?) -> Void) {

        if let response = response as? HTTPURLResponse {
            
            guard response.statusCode == 200 || response.statusCode == 201 else {
                debugData(response: response, data: data, urlRequest: urlRequest, method: method)
                handleError(endPoint: endPoint, response: response, data: data, urlRequest: urlRequest, method: method, completion: completion)
                return
            }
            deletage?.accessTokenTrigger(isActive: true)
            
            guard let data = data else { return }
            
            do {
                let decode = try JSONDecoder().decode(T.self, from: data)
                getQueryItem(endPoint: endPoint, decodable: decode)
                getAccessToken(decodable: decode)
                completion(decode, nil)
                return
            }
            catch {
                self.decodingError(error: error)
                completion(nil, NetworkError.badParsing)
            }
        }
    }
//    MARK: getQueryItem
    func getQueryItem(endPoint: EndPoint, decodable: Decodable) {
        if endPoint.url == AuthEndPoint.trustOTP.url {
            if let data = decodable as? IDTokenSuccessModel {
                UserDefaults.standard.queryToken = data.data
            }
        }
    }
    
//    MARK: SetQueryItem
    func setQueryItem(url: inout URLComponents) {
        guard let token = UserDefaults.standard.queryToken else { return }
        url.queryItems = [URLQueryItem(name: "token", value: token)]
        
        UserDefaults.standard.queryToken = nil
    }
    
//    MARK: GetAccessTokentoken
    func getAccessToken(decodable: Decodable) {

        if let decode = decodable as? LoginSuccessModel {
            print(decode.data?.accessToken ?? "" )
            UserDefaults.standard.accessToken = decode.data?.accessToken
            UserDefaults.standard.refreshToken = decode.data?.refreshToken
        }
    }
    
//    MARK: setAccessToken
    func setAccessToken(urlRequest: inout URLRequest) {
        guard let accessToken = UserDefaults.standard.accessToken else { return }
        urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: TokenEnum.accessToken.value)
    }
    
//    MARK: Send refresh
    func sendRefreshToken(completion: @escaping(Result<RefreshTokenSuccessModel, Error>) -> Void) {
        UserDefaults.standard.accessToken = nil
        guard let refreshToken = UserDefaults.standard.refreshToken else {
            completion(.failure(NetworkError.unauthorization));
            return }
        do {
            let body = RefreshTokenModel(token: refreshToken)
            let encode = try JSONEncoder().encode(body)
            POST(endPoint: EndPoint.auth(.loginRefreshToken), body: encode) { (data: RefreshTokenSuccessModel?, error: Error?) in
                if let error {
                    completion(.failure(NetworkError.unauthorization))
                    self.deletage?.accessTokenTrigger(isActive: false)
                    UserDefaults.standard.refreshToken = nil
                    print(error.localizedDescription)
                }
                
                if let data {
                    UserDefaults.standard.accessToken = data.data?.token
                    completion(.success(data))
                }
            }
        }
        catch {
            print(error.localizedDescription)
            
            completion(.failure(NetworkError.unauthorization))
        }
    }
    
    private func sendNew<T: Decodable>(urlRequest forNewAccessToken: URLRequest, endPoint: EndPoint, method: HTTPMethod, completion: @escaping(T?, Error?) -> Void) {
        
        var newRequest = forNewAccessToken
        setAccessToken(urlRequest: &newRequest)
        URLSession.shared.dataTask(with: newRequest) { data, response, error in
            
            self.checkError(error: error, completion: completion)
            self.checkStatus(endPoint: endPoint, response: response, data: data, urlRequest: newRequest, method: method, completion: completion)
        }.resume()
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
    
    public func GET<T: Decodable>(endPoint: EndPoint,completion: @escaping(T?, Error?) -> Void) where T : Decodable  {
        self.request(endPoint: endPoint, method: .GET, body: nil) { (data: T?, error: Error?) in
            if let err = error as? NetworkError {
                completion(nil, err)
                return
            }
            
            if let result = data {
                completion(result, nil)
            }
        }
    }
    
    public func POST<T: Decodable>(endPoint: EndPoint, body: Data?, completion: @escaping(T?, Error?) -> Void) where T : Decodable   {
        self.request(endPoint: endPoint, method: .POST, body: body) { (data: T?, error: Error?) in
            if let err = error as? NetworkError {
                completion(nil, err)
                return
            }
            
            if let result = data {
                completion(result, nil)
            } else {
                completion(nil, NetworkError.corruptedData)
            }
        }
    }
    
    public func PUT<T: Decodable>(endPoint: EndPoint, body: Data?, completion: @escaping(T?, Error?) -> Void) {
        
        self.request(endPoint: endPoint, method: .PUT, body: body) { (data: T?, error: Error? ) in
            if let err = error as? NetworkError {
                completion(nil, err)
                return
            }
            
            if let result = data {
                completion(result, nil)
            }
        }
    }
    
    
    public func DELETE<T: Decodable>(endPoint: EndPoint, body: Data?, completion: @escaping(T?, Error?) -> Void) {
        self.request(endPoint: endPoint, method: .DELETE, body: body) { (data: T?, error: Error? ) in
            if let err = error as? NetworkError {
                completion(nil, err)
                return
            }
            
            if let result = data {
                completion(result, nil)
            }
        }
    }
}

extension HTTPClient {
//    MARK: --
    private func handleError<T: Decodable>(endPoint: EndPoint, response: HTTPURLResponse, data: Data?, urlRequest: URLRequest, method: HTTPMethod, completion: @escaping(T?, Error?) -> Void){
        do {
            guard let data = data else { return
                completion(nil, NetworkError.badParsing)
            }
            
            let errorDecode = try JSONDecoder().decode(ErrorModel.self, from: data)
            
            switch response.statusCode {
            case 400:
                completion(nil, NetworkError.badRequest(errorDecode.message ?? ""))
            case 401:
                if endPoint.url != AuthEndPoint.loginRefreshToken.url {
                    handleUnauthorized(endPoint: endPoint, urlRequest: urlRequest, method: method, completion: completion)
                } else {
                    completion(nil, NetworkError.badRequest(errorDecode.message ?? ""))
                }
            case 402...403:
                completion(nil, NetworkError.unauthorization)
            case 404:
                completion(nil, NetworkError.badRequest(errorDecode.message ?? ""))
            case 409:
                completion(nil, NetworkError.statusCode("\(response.statusCode)"))
            case 500:
                completion(nil, NetworkError.badRequest(errorDecode.message ?? ""))
            default:
                completion(nil, NetworkError.statusError)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func handleUnauthorized<T: Decodable>(endPoint: EndPoint, urlRequest: URLRequest, method: HTTPMethod, completion: @escaping(T?, Error?) -> Void){
        sendRefreshToken { result in
            switch result {
            case .success(_):
                print("\(endPoint.url) ---------- URL ----------")
                self.sendNew(urlRequest: urlRequest, endPoint: endPoint, method: method, completion: completion)
            case .failure(let error):
                if let networkError = error as? NetworkError , case NetworkError.unauthorization = networkError {
                    UserDefaults.standard.refreshToken = nil
                    completion(nil, NetworkError.refreshTokenTimeIsOver)
                }
            }
        }
    }
    
    private func debugData(response: HTTPURLResponse, data: Data?, urlRequest: URLRequest, method: HTTPMethod){
        if let httpBody = urlRequest.httpBody {
            print((try? JSONSerialization.jsonObject(with: httpBody)) ?? "CANNOT HANDLE TRY")
        }
        print("\(method.rawValue)", response)
                            
        if let data, let result = String(data: data, encoding: .utf8) {
            print(result)
        }
    }
}
