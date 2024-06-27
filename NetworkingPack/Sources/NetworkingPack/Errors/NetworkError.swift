//
//  NetworkError.swift
//
//
//  Created by Valeh Amirov on 13.06.24.
//

import Foundation

public enum NetworkError: Error, LocalizedError {
    case badUrl
    case badRequest(String)
    case badParsing
    case timeOut
    case noInternetConnection
    case notFound(String)
    case unauthorization
    case refreshTokenTimeIsOver
    case statusError
    case corruptedData
    case unknowned
    case statusCode(String)

    
    public var errorDescription: String? {
        switch self {
        case .badUrl:
            return "Bad url for this request"
        case .badRequest(let result):
            return result
        case .badParsing:
            return "Bad parsing your decodable"
        case .timeOut:
            return " Your request Time out in limit"
        case .noInternetConnection:
            return "No internetConnection"
        case .unauthorization:
            return "Not your authorization"
        case .notFound(let result):
            return result
        case .statusError:
            return "Status error"
        case .corruptedData:
            return "Corrupted data"
        case .unknowned:
            return "Unknowned"
        case .refreshTokenTimeIsOver:
            return "Sessiya bitmişdir yenidən login olun"
        case .statusCode(let number):
            return number
        
        }
    }
}

public extension LocalizedError {
    
    var errorDescription: String {
        return (self as NSError).localizedDescription
    }
}
