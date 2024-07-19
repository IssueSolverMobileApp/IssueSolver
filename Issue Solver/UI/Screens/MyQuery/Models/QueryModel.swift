//
//  QueryModel.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 09.07.24.
//


import Foundation

// MARK: - QueryModel
struct QueryModel: Codable, Hashable {
    var data: [QueryDataModel]?
    var message: String?
    var success: Bool?
    
    static func ==(lhs: QueryModel, rhs: QueryModel) -> Bool {
        return lhs.data == rhs.data && lhs.message == rhs.message && lhs.success == rhs.success
    }
}

// MARK: - QueryDataModel
struct QueryDataModel: Codable, Hashable {
    var requestID: Int?
    var fullName, address, description, status: String?
    var organizationName, createDate: String?
    var commentCount, likeCount: Int?
    var likeSuccess: Bool?
    var category: QueryCategoryModel?
    
    static func ==(lhs: QueryDataModel, rhs: QueryDataModel) -> Bool {
        return lhs.requestID == rhs.requestID && lhs.fullName == rhs.address && lhs.description == rhs.description && lhs.status == rhs.status && lhs.organizationName == rhs.organizationName && lhs.createDate == rhs.createDate && lhs.commentCount == rhs.commentCount && lhs.likeCount == rhs.likeCount && lhs.likeSuccess == rhs.likeSuccess && lhs.category == rhs.category
        
    }    
    
    enum CodingKeys: String, CodingKey {
        case requestID = "requestId"
        case fullName, address, description, status, organizationName, createDate, commentCount, likeCount, likeSuccess, category
    }
}
    
// MARK: - QueryCategoryModel
struct QueryCategoryModel: Codable, Hashable {
    var categoryID: Int?
    var categoryName: String?
    
    static func ==(lhs: QueryCategoryModel, rhs: QueryCategoryModel) -> Bool {
        return lhs.categoryID == rhs.categoryID && lhs.categoryName == rhs.categoryName
    }
    
    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case categoryName
    }
}
