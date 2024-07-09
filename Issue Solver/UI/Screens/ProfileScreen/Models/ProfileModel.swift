//
//  ProfileModel.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 21.06.24.
//


import Foundation

// MARK: - ProfileSuccessModel
struct ProfileSuccessModel: Codable {
    let data: ProfileDataModel?
    let message: String?
    let success: Bool?
}

// MARK: - ProfileDataModel
struct ProfileDataModel: Codable {
    let email, fullName, createdTime, modifiedTime: String?
    
}

