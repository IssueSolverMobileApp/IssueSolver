//
//  HomeEndPoint.swift
//  
//
//  Created by Irada Bakirli on 12.07.24.
//

import Foundation

public enum HomeEndpoint: EndPointProtocol {
    
    case allRequests(String)
    
    var url: String {
        switch self {
        case .allRequests(let pageNumber):
            return "\(baseURL)request?page=\(pageNumber)&size=10"
        }
    }
}

