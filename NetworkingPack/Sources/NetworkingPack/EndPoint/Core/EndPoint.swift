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
    case home(HomeEndpoint)
    
    var url: String {
        switch self {
        case .auth(let authEndPoint):
            return authEndPoint.url
        case .profile(let profileEndPoint):
            return profileEndPoint.url
        case .myQuery(let myQueryEndPoint):
            return myQueryEndPoint.url
        case .home(let homeEndPoint):
            return homeEndPoint.url
        }
    }
}

protocol EndPointProtocol {
    var baseURL: String { get }
}

extension EndPointProtocol {
    
    var baseURL: String {
        return "https://issue-solver-421da800ab88.herokuapp.com/"
    }
}
