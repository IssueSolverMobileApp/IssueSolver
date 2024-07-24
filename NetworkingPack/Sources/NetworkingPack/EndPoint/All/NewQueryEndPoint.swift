//
//  File.swift
//  
//
//  Created by Vusal Nuriyev on 22.07.24.
//

import Foundation

public enum NewQueryEndPoint: EndPointProtocol {
    
    case request(String)
    case category
    case organizations
    
    var url: String {
        switch self {
        case .request(let query):
            return "\(baseURL)request?categoryName=\(query)"
        case .category:
            return "\(baseURL)category"
        case .organizations:
            return "\(baseURL)api/Organizations/getList"
        }
    }
}
