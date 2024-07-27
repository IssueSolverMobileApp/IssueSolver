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
struct QueryDataModel: Codable, Hashable, Identifiable {
    var id: Int {
        return requestID ?? 0
    }
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

extension QueryDataModel {
    static func mock(with id: Int) -> QueryDataModel {
        .init(requestID: id, fullName: "Fexri", address: "Baki", description: "Salam", status: "Gözləmədə", organizationName: "IDDA", createDate: "", commentCount: 0, likeCount: 0, likeSuccess: true, category: nil)
    }
    
    static func mockArray() -> [QueryDataModel] {
        return [QueryDataModel.mock(with: 1), QueryDataModel.mock(with: 2), QueryDataModel.mock(with: 3), QueryDataModel.mock(with: 3)]
    }
}
    
// MARK: - QueryCategoryModel
struct QueryCategoryModel: SelectionProtocol, Codable {
    var categoryID: Int?
    var name: String?
    
    static func ==(lhs: QueryCategoryModel, rhs: QueryCategoryModel) -> Bool {
        return lhs.categoryID == rhs.categoryID && lhs.name == rhs.name
    }
    
    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case name = "categoryName"
    }
}

// MARK: - CommentDeleteSuccessModel
struct QueryDeleteSuccessModel: Codable {
    let data, message: String?
    let success: Bool?
    let fullName: String?
}
