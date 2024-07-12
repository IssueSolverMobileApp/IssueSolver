//
//  QueryModel.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 09.07.24.
//


import Foundation

// MARK: - QueryModel
struct QueryModel: Codable {
    let data: QueryDataModel?
    let message: String?
    let success: Bool?
}

// MARK: - QueryDataModel
struct QueryDataModel: Codable {
    let requestID: Int?
    let fullName, address, description, status: String?
    let organizationName, createDate: String?
    let commentCount, likeCount: Int?
    let likeSuccess: Bool?
    let category: QueryCategoryModel?

    enum CodingKeys: String, CodingKey {
        case requestID = "requestId"
        case fullName, address, description, status, organizationName, createDate, commentCount, likeCount, likeSuccess, category
    }
}

// MARK: - QueryCategoryModel
struct QueryCategoryModel: Codable {
    let categoryID: Int?
    let categoryName: String?

    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case categoryName
    }
}

