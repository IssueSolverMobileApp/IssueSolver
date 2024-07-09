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
    var baseAuthURL: String { get }
    var baseRequestMSURL: String { get }
    var baseAdminMSURL: String { get }
}

extension EndPointProtocol {
    
    var baseAuthURL: String {
        return "https://govermentauthapi20240708181106.azurewebsites.net/api/"
    }
    
    var baseRequestMSURL: String {
        return "https://request-ms-d25203bd24ff.herokuapp.com/"
    }
    
    var baseAdminMSURL: String {
        return "https://adminapi20240708182629.azurewebsites.net/api/"
    }
}
