//
//  QueryModel.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 09.07.24.
//


import Foundation

// MARK: - QueryModel
struct QueryModel: Codable {
    var data: QueryDataModel?
    var message: String?
    var success: Bool?
}

// MARK: - QueryDataModel
struct QueryDataModel: Codable {
    var requestID: Int?
    var fullName, address, description, status: String?
    var organizationName, createDate: String?
    var commentCount, likeCount: Int?
    var likeSuccess: Bool
    var category: QueryCategoryModel?

    enum CodingKeys: String, CodingKey {
        case requestID = "requestId"
        case fullName, address, description, status, organizationName, createDate, commentCount, likeCount, likeSuccess, category
    }
}

// MARK: - QueryCategoryModel
struct QueryCategoryModel: Codable {
    var categoryID: Int?
    var categoryName: String?

    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case categoryName
    }
}

