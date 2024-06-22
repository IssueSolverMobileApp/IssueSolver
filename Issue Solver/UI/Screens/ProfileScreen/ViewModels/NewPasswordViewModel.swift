//
//  NewPasswordViewModel.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 23.06.24.
//

import Foundation

class NewPasswordViewModel: ObservableObject {
    
    private var authRepository = HTTPAuthRepository()
    
    @Published var currentPasswordText = ""
    @Published var newPasswordText = ""
    @Published var confirmPasswordtext = ""
    
}
