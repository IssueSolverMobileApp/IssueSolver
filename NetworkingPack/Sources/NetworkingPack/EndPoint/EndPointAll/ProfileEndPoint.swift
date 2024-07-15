//
//  ProfileEndPoint.swift
//
//
//  Created by Irada Bakirli on 05.07.24.
//

import Foundation

public enum ProfileEndPoint: EndPointProtocol {
    
    case deleteAccount
    case changePassword
    case updateFullName
    
    var url: String {
        switch self {
        case .deleteAccount:
            return "\(baseURL)Users/delete"
        case .updateFullName:
            return "\(baseURL)Users/updatefullname"
        case .changePassword:
            return "\(baseURL)Users/updatepassword"    
        }
    }
}
