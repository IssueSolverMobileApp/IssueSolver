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


// MARK: - ErrorModel
struct ErrorModel: Codable {
    let timeSpam: String?
    let url: String?
    let title: String?
    let success: Bool?
    let status: Int?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case timeSpam = "TimeSpam"
        case url = "Url"
        case title = "Title"
        case success = "Success"
        case status = "Status"
        case message = "Message"
    }
}

// MARK: - RegisterSuccessModel
//struct RegisterSuccessModel: Codable {
//    let success: Bool?
//    let status: Int?
//    let message: String?
//}
