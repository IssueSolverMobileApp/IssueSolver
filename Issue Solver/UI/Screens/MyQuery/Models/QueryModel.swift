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


// MARK: - QueryDataModel
struct QueryDataModel: Codable, Identifiable {
    let id = UUID()
    let requestID: Int?
    let fullName, email, address, description: String?
    let status, organizationName, createDate, lastModified: String?
    let commentCount, likeCount: Int?
    let like: [QueryLikeModel]?
    let comment: [QueryCommentModel]?
    let category: QueryCategoryModel?

    enum CodingKeys: String, CodingKey {
        case requestID = "requestId"
        case fullName, email, address, description, status, organizationName, createDate, lastModified, commentCount, likeCount, like, comment, category
    }
}

// MARK: - QueryCategoryModel
struct QueryCategoryModel: Codable {
    let categoryID: Int?
    let categoryName, createDate, lastModified: String?

    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case categoryName, createDate, lastModified
    }
}

// MARK: - QueryCommentModel
struct QueryCommentModel: Codable {
    let commentID: Int?
    let fullName, email: String?
    let commentCount: Int?
    let authority, commentText, createDate, lastModified: String?

    enum CodingKeys: String, CodingKey {
        case commentID = "commentId"
        case fullName, email, commentCount, authority, commentText, createDate, lastModified
    }
}

// MARK: - QueryLikeModel
struct QueryLikeModel: Codable {
    let likeID: Int?
    let fullName, email: String?
    let likeCount: Int?
    let createDate, lastModified: String?

    enum CodingKeys: String, CodingKey {
        case likeID = "likeId"
        case fullName, email, likeCount, createDate, lastModified
    }
}


// MARK: - LikeSuccessModel
struct LikeSuccessModel: Codable {
    let data: QueryLikeModel?
    let message: String?
    let success: Bool?
}

