//
//  PassowordChangeViewModel.swift
//  Issue Solver
//
//  Created by ValehAmirov on 14.06.24.
//

import Foundation

class PasswordChangeViewModel: ObservableObject {
    
    private var authRepository = HTTPAuthRepository()

    @Published var passwordText: String = ""
    @Published var confirmPasswordText: String = ""
    
}
