//
//  RegisterModel.swift
//  Issue Solver
//
//  Created by ValehAmirov on 13.06.24.
//

import Foundation

struct RegisterModel: Codable {
    let email, fullName, password: String?
    let confirmPassword: String?
    
    enum CodingKeys: String, CodingKey {
        case email
        case fullName = "firstName"
        case password
        case confirmPassword
    }
}

// MARK: - RegisterErrorModel
struct ErrorModel: Codable {
    let errors: String?
    let type: String?
    let title: String?
    let status: Int?
    let detail, instance: String?
    let extensions: String?

    enum CodingKeys: String, CodingKey {
        case errors = "Errors"
        case type = "Type"
        case title = "Title"
        case status = "Status"
        case detail = "Detail"
        case instance = "Instance"
        case extensions = "Extensions"
    }
}
