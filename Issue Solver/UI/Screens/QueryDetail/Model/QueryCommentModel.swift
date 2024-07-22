//
//  QueryCommentModel.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 22.07.24.
//

import Foundation

// MARK: - QueryCommentModel
struct QueryCommentModel: Codable {
    let data: [QueryCommentDataModel]
    let message: String
    let success: Bool
}

// MARK: - Datum
struct QueryCommentDataModel: Codable {
    let commentID: Int
    let fullName, authority, commentText, createDate: String

    enum CodingKeys: String, CodingKey {
        case commentID = "commentId"
        case fullName, authority, commentText, createDate
    }
}
