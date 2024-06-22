//
//  RegisterModel.swift
//  Issue Solver
//
//  Created by ValehAmirov on 14.06.24.
//

import Foundation

// MARK: - RegisterModel
struct RegisterModel: Codable {
    let email, fullName, password, confirmPassword: String
    
    enum CodingKeys: CodingKey {
        case email
        case fullName
        case password
        case confirmPassword
    }
}
