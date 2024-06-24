//
//  DeleteAccountViewModel.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 23.06.24.
//

import Foundation

class DeleteAccountViewModel: ObservableObject {
    
    private var authRepository = HTTPAuthRepository()
    
    @Published var passwordText = ""
    @Published  var isRightField = true
}
