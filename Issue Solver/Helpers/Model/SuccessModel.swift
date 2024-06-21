//
//  SuccessModel.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 20.06.24.
//

import Foundation

// MARK: - SuccessModel
struct SuccessModel: Codable {
    let data: TokenData?
    let success: Bool?
    let status: Int?
    let message: String?
}

// MARK: - DataClass
struct TokenData: Codable {
    let accessToken, refreshToken: String?
}
