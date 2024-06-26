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
    
    
    func updatePassword() async {
        let item = ResetPasswordModel(password: passwordText, confirmPassword: confirmPasswordText)
        
        authRepository.resetPassword(body: item) { result in
            switch result {
            case .success(let success):
                print(success.message ?? "")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
