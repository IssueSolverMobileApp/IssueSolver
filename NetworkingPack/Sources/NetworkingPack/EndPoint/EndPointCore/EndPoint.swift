//
//  EndPoint.swift
//  
//
//  Created by Valeh Amirov on 22.06.24.
//

import Foundation

public enum EndPoint: EndPointProtocol {
    
    case auth(AuthEndPoint)
    case profile(ProfileEndPoint)
    case myQuery(MyQueryEndPoint)
    
    var url: String {
        switch self {
        case .auth(let authEndPoint):
            return authEndPoint.url
        case .profile(let profileEndPoint):
            return profileEndPoint.url
        case .myQuery(let myQueryEndPoint):
            return myQueryEndPoint.url
        }
    }
}

protocol EndPointProtocol {
    var baseURL: String { get }
    var baseRequestMS: String { get }
}

extension EndPointProtocol {
    
    var baseURL: String {
        return "https://govermentauthapi20240610022027.azurewebsites.net/api/"
    }
    
    var baseRequestMS: String {
        return "https://request-ms-d25203bd24ff.herokuapp.com/"
    }
}
