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
    
    var url: String {
        switch self {
        case .request(let query):
            return "\(baseRequestMSURL)request?categoryName=\(query)"
        case .category:
            return "\(baseRequestMSURL)category"
        }
    }
}
