//
//  MyAccountViewModel.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 23.06.24.
//

import Foundation

class MyAccountViewModel: ObservableObject {
    
    private var authRepository = HTTPAuthRepository()
    
    @Published var fullNameText = ""
    @Published var emailText = ""
    @Published  var isRightField = true
}
