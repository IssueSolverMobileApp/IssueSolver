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
            return "\(baseAuthURL)Users/delete"
        case .updateFullName:
            return "\(baseAuthURL)Users/updatefullname"
        case .changePassword:
            return "\(baseAuthURL)Users/updatepassword"    
        }
    }
}
