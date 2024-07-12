//
//  CategoryModel.swift
//  Issue Solver
//
//  Created by Vusal Nuriyev on 12.07.24.
//

import Foundation

// MARK: - Welcome
struct CategoryData: Codable {
    let data: [CategoryModel]?
    let message: String?
    let success: Bool?
}

// MARK: - Datum
struct CategoryModel: Codable, Hashable, Identifiable {
    let id: Int
    let categoryName, createDate, lastModified: String?

    enum CodingKeys: String, CodingKey {
        case id = "categoryId"
        case categoryName, createDate, lastModified
    }
}
