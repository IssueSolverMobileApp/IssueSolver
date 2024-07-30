//
//  CategoryModel.swift
//  Issue Solver
//
//  Created by Vusal Nuriyev on 22.07.24.
//

import Foundation

struct CategoryData: Codable {
    var data: [QueryCategoryModel]?
    var message: String?
    var success: Bool?    
}
