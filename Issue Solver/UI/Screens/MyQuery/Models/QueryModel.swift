//
//  QueryModel.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 09.07.24.
//
 import Foundation

// MARK: - QueryModel
struct QueryModel: Codable {
    let data: [QueryDataModel]?
    let message: String?
    let success: Bool?
}

// MARK: - Datum
struct QueryDataModel: Codable {
    let requestID: Int?
    let fullName, email, address, description: String?
    let status, organizationName, createDate, lastModified: String?
    let commentCount, likeCount: Int?
    let likeSuccess: Bool?
    let category: QueryCategoryModel?

    enum CodingKeys: String, CodingKey {
        case requestID = "requestId"
        case fullName, email, address, description, status, organizationName, createDate, lastModified, commentCount, likeCount, likeSuccess, category
    }
}

// MARK: - Category
struct QueryCategoryModel: Codable {
    let categoryID: Int?
    let categoryName: String?

    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case categoryName
    }
}

