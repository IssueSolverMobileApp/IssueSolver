//
//  FilterEndPoint.swift
//  
//
//  Created by Irada Bakirli on 23.07.24.
//


import Foundation

public enum FilterEndPoint: EndPointProtocol {
    case filter(String, String, String, String, String)
    
    var url: String {
        switch self {
        case .filter(let status, let category, let organization, let days, let pageNumber ):
            return "\(baseURL)request/filter?status=\(status)&categoryName=\(category)&organizationName=\(organization)&days=\(days)&page=\(pageNumber)&size=10"
        }
    }
}
