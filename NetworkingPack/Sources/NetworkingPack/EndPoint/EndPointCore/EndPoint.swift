//
//  EndPoint.swift
//  
//
//  Created by Valeh Amirov on 22.06.24.
//

import Foundation

public enum EndPoint: EndPointProtocol {
    
    case auth(AuthEndPoint)
    
    var url: String {
        switch self {
        case .auth(let authEndPoint):
            return authEndPoint.url
        }
    }
}

protocol EndPointProtocol {
    var baseURL: String { get }
}

extension EndPointProtocol {
    
    var baseURL: String {
        return "https://govermentauthapi20240610022027.azurewebsites.net/api/"
    }
}
