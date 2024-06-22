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
