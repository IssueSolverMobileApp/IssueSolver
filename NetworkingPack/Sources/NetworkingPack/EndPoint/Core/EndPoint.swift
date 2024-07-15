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
    var baseRequestMSURL: String { get }
    var baseAdminMSURL: String { get }
}

extension EndPointProtocol {
    
    var baseURL: String {
        return "https://issue-solver-421da800ab88.herokuapp.com/api/"
    }
    
    var baseRequestMSURL: String {
        return "https://request-ms-d25203bd24ff.herokuapp.com/"
    }
    
    var baseAdminMSURL: String {
        return "https://adminapi20240708182629.azurewebsites.net/api/"
    }
}
