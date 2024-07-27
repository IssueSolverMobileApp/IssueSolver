//
//  FilterModel.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 23.07.24.
//

import Foundation

struct StatusModel: SelectionProtocol {
    var id = UUID()
    var name: String?
    
    var nameWithoutSpaces: String {
        name?.replacingOccurrences(of: " ", with: "") ?? ""
    }
}

struct DateModel: SelectionProtocol {
    var id = UUID()
    var name: String?

}
