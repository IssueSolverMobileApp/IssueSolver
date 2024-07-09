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
    
    var url: String {
        switch self {
        case .deleteAccount:
            return "\(baseAuthURL)Users/delete"
        case .changePassword:
            return "SALAM BUNU DEYISH"
        }
    }
}
