//
//  OrganizationModel.swift
//  Issue Solver
//
//  Created by Vusal Nuriyev 2 on 22.07.24.
//

import Foundation

struct OrganizationData: Codable {
    let data: [OrganizationModel]?
    let message: String?
    let success: Bool?
}

struct OrganizationModel: SelectionProtocol, Codable, Identifiable {
    var id: UUID? = UUID()
    var name: String?
    var active: Bool?
}
