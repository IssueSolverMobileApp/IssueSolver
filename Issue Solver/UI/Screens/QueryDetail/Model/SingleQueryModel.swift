//
//  SingleQueryModel.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 21.07.24.
//

import Foundation

// MARK: - SingleQueryModel
struct SingleQueryModel: Codable {
    let data: QueryDataModel
    let message: String
    let success: Bool
}
