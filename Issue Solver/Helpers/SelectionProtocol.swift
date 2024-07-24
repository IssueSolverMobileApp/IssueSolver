//
//  SelectionProtocol.swift
//  Issue Solver
//
//  Created by Vusal Nuriyev 2 on 22.07.24.
//

import SwiftUI

protocol SelectionProtocol: Hashable, Codable {
    var name: String? { get }
}
