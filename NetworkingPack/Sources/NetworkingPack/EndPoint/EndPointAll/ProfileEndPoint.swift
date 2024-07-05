//
//  ProfileEndPoint.swift
//
//
//  Created by Irada Bakirli on 05.07.24.
//

import Foundation

public enum ProfileEndPoint: EndPointProtocol {
    
    case deleteAccount
    
    var url: String {
        switch self {
        case .deleteAccount:
            return "\(baseURL)Users/delete"
        }
    }
}
