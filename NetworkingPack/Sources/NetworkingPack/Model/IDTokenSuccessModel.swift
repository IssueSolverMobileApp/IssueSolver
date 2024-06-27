//
//  IDTokenSuccessModel.swift
//  
//
//  Created by Valeh Amirov on 22.06.24.
//

import Foundation
// MARK: - ResendOTPSuccessModel
public struct IDTokenSuccessModel: Codable {
    let data: String?
    let success: Bool?
    let status: Int?
    let message: String?
}



// MARK: - RefreshTokenModel
public struct RefreshTokenModel: Codable {
    let token: String?
}

// MARK: - RefreshTokenSuccessModel
struct RefreshTokenSuccessModel: Codable {
    let data: String?
    let success: Bool?
    let status: Int?
    let message: String?
}


public struct LoginSuccessModel: Codable {
    let data: TokenModel?
    let success: Bool?
    let status: Int?
    public let message: String?
}

public struct TokenModel: Codable {
    let accessToken, refreshToken: String?
}
