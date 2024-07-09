//
//  MyQueryEndPoint.swift
//
//
//  Created by Valeh Amirov on 09.07.24.
//

import Foundation

public enum MyQueryEndPoint: EndPointProtocol {
    
    case myquery(String)
    
    var url: String {
        switch self {
        case .myquery(let pageNumber):
            return "\(baseRequestMSURL)request/user-requests?page=\(pageNumber)&size=10&sortBy=createDate"
        }
    }
}
