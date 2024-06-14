//
//  AuthViewModel.swift
//  Issue Solver
//
//  Created by Vusal Nuriyev on 12.06.24.
//

import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var fullNameText: String = ""
    @Published var emailText: String = ""
    @Published var passwordText: String = ""
    @Published var confirmPasswordText: String = ""
    
    
}
