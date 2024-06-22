//
//  OTPModel.swift
//  Issue Solver
//
//  Created by ValehAmirov on 14.06.24.
//

import Foundation


// MARK: - OTPModel
struct OTPModel: Codable {
    let otpCode: String?
}

// MARK: - OTPSuccessModel
//struct ConfirmOTPSuccessModel: Codable {
//    let success: Bool?
//    let status: Int?
//    let message: String?
//}

// MARK: - ResendOTPSuccessModel
struct IDTokenSuccessModel: Codable {
    let data: String?
    let success: Bool?
    let status: Int?
    let message: String?
}
