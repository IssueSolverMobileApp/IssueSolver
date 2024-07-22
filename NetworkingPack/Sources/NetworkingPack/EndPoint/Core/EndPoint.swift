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
    case query(QueryEndPoint)
    case newQuery(NewQueryEndPoint)
    case home(HomeEndpoint)
    
    var url: String {
        switch self {
        case .auth(let authEndPoint):
            return authEndPoint.url
        case .profile(let profileEndPoint):
            return profileEndPoint.url
        case .query(let myQueryEndPoint):
            return myQueryEndPoint.url
        case .newQuery(let newQueryEndPoint):
            return newQueryEndPoint.url
        case .home(let homeEndPoint):
            return homeEndPoint.url
        }
    }
}

protocol EndPointProtocol {
    var baseURL: String { get }
    var baseRequestMSURL: String { get }
}

extension EndPointProtocol {
    
    var baseURL: String {
        return "https://gatewayy-f20db7ab0323.herokuapp.com/"
    }
    var baseRequestMSURL: String {
        return "https://request-mss-05fdbd39d8f8.herokuapp.com/"
    }
}
