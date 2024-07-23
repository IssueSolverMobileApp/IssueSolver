//
//  FilterModel.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 23.07.24.
//

import Foundation

struct StatusModel: SelectionProtocol {
    var name: String?
    
    init(name: String) {
        self.name = name
    }
}

struct DateModel: SelectionProtocol {
    var name: String?
    
    init(name: String) {
        self.name = name
    }
}
