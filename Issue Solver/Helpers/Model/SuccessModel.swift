//
//  SuccessModel.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 20.06.24.
//

import Foundation

// MARK: - SuccessModel
struct SuccessModel: Codable {
    let data, message: String?
    let success: Bool?
}
