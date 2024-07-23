//
//  QueryCommentModel.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 22.07.24.
//

import Foundation

// MARK: - QueryCommentModel
struct QueryCommentModel: Codable, Hashable {
    let data: [QueryCommentDataModel]?
    let message: String?
    let success: Bool?
    
    static func ==(lhs: QueryCommentModel, rhs: QueryCommentModel) -> Bool {
        return lhs.success == rhs.success && lhs.message == rhs.message && lhs.data == rhs.data
    }
}

// MARK: - QueryCommentDataModel
struct QueryCommentDataModel: Codable, Hashable {
    var commentID: Int?
    var commentIsSuccess: Bool? = true
    var fullName, authority, commentText, createDate: String?

    
    static func ==(lhs: QueryCommentDataModel, rhs: QueryCommentDataModel) -> Bool {
        return lhs.commentID == rhs.commentID && lhs.commentIsSuccess == rhs.commentIsSuccess && lhs.fullName == rhs.fullName && lhs.authority == rhs.authority && lhs.commentText == rhs.commentText && lhs.createDate == rhs.createDate
    }
    
    enum CodingKeys: String, CodingKey {
        case commentID = "commentId"
        case fullName, authority, commentText, createDate
    }
}

// MARK: - PostCommentModel
struct PostCommentModel: Codable {
    let commentText: String?
}


// MARK: - CommentSuccessModel
struct CommentSuccessModel: Codable {
    let data: QueryCommentDataModel?
    let message: String?
    let success: Bool?
    let fullName: String?
}

// MARK: - CommentSuccessDataModel
//struct CommentSuccessDataModel: Codable {
//    let commentID: Int?
//    let fullName, authority, commentText, createDate: String?
//
//    enum CodingKeys: String, CodingKey {
//        case commentID = "commentId"
//        case fullName, authority, commentText, createDate
//    }
//}
