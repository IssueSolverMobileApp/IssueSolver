//
//  File.swift
//  
//
//  Created by Valeh Amirov on 04.06.24.
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
    case statusError
    case corruptedData
    case unknowned
    
    var errorDescription: String {
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
        }
    }
}
