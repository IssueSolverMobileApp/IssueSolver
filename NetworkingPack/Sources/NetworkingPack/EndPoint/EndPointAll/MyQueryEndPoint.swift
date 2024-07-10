//
//  MyQueryEndPoint.swift
//
//
//  Created by Valeh Amirov on 09.07.24.
//

import Foundation

public enum MyQueryEndPoint: EndPointProtocol {
    
    case myquery(String)
    case likePost(String)
    case likeDelete(String)
    
    var url: String {
        switch self {
        case .myquery(let pageNumber):
            return "\(baseRequestMSURL)request/user-requests?page=\(pageNumber)&size=10&sortBy=createDate"
        case .likePost(let requestID):
            return "\(baseRequestMSURL)api/v1/likes/post?requestId=\(requestID)"
        case .likeDelete(let likeID):
            return "\(baseRequestMSURL)api/v1/likes?likeId=\(likeID)"
        }
    }
}
