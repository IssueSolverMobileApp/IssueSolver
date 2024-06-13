//
//  ResetPasswordModel.swift
//  Issue Solver
//
//  Created by ValehAmirov on 13.06.24.
//

import Foundation

// MARK: - ResetPasswordModel
struct ResetPasswordModel: Codable {
    let otpCode, password, confirmPassword: String?
}
