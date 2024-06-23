//
//  LoginModel.swift
//  Issue Solver
//
//  Created by ValehAmirov on 14.06.24.
//

import Foundation

// MARK: - Loginmodel
struct LoginModel: Codable {
    let email, password: String?
}

// MARK: - OTPSuccessModel
struct LoginSuccessModel: Codable {
    let data: TokenModel?
    let success: Bool?
    let status: Int?
    let message: String?
}

// MARK: - DataClass
struct TokenModel: Codable {
    let accessToken, refreshToken: String?
}

