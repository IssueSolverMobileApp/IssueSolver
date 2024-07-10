//
//  UpdatePasswordModel.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 09.07.24.
//

import Foundation

// MARK: - UpdatePasswordModel
struct UpdatePasswordModel: Codable {
    let currentPassword, password, confirmPassword: String?
}
