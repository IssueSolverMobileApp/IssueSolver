//
//  FilterModel.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 23.07.24.
//

import Foundation

struct StatusModel: SelectionProtocol {
    var name: String?
    
    static var none: StatusModel {
        StatusModel(name: "Heç biri")
    }
    
    var nameWithoutSpaces: String {
        name?.replacingOccurrences(of: " ", with: "") ?? ""
    }
}

struct DateModel: SelectionProtocol {
    var name: String?
    
    static var none: DateModel {
        DateModel(name: "Heç biri")
    }
}
