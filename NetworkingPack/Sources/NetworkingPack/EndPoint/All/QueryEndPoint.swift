//
//  QueryEndPoint.swift
//
//
//  Created by Valeh Amirov on 09.07.24.
//

import Foundation

public enum QueryEndPoint: EndPointProtocol {
    
    case myQueries(String)
    case singleQuery(String)
    case deleteQuery(String)
    case getQueryComments(String, String)
    case postComment(String)
    case likePost(String)
    case likeDelete(String)
    
    var url: String {
        switch self {
        case .myQueries(let pageNumber):
            return "\(baseURL)request/user-requests?page=\(pageNumber)&size=10&sortBy=createDate"
        case .singleQuery(let requestID):
            return "\(baseURL)request/by-id/\(requestID)"
        case .deleteQuery(let requestID):
            return "\(baseURL)request/\(requestID)" 
        case .getQueryComments(let requestID, let pageNumber):
            return "\(baseURL)api/v1/comments/request/\(requestID)?page=\(pageNumber)&size=10"
        case .postComment(let requestID):
        return "\(baseURL)api/v1/comments/post?requestId=\(requestID)"
        case .likePost(let requestID):
            return "\(baseURL)api/v1/likes/post?requestId=\(requestID)"
        case .likeDelete(let requestID):
            return "\(baseURL)api/v1/likes?requestId=\(requestID)"
        }
    }
}
