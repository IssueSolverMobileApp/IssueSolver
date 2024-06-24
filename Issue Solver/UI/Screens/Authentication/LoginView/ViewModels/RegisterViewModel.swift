//
//  RegisterViewModel.swift
//  Issue Solver
//
//  Created by ValehAmirov on 20.06.24.
//

import Foundation

class RegisterViewModel: ObservableObject {
    
    private var authRepository = HTTPAuthRepository()
    
    @Published var fullNameText: String = ""
    @Published var emailText: String = ""
    @Published var passwordText: String = ""
    @Published var confirmPasswordText: String = ""
    
    
    func register(completion: @escaping (Bool) -> Void) async {
        let item = RegisterModel(email: emailText, fullName: fullNameText, password: passwordText, confirmPassword: confirmPasswordText)
        do {
            let result = try await authRepository.register(body: item)
            completion(result?.success ?? false)
            //            navigateOTPView = result?.success ?? false
            print(result ?? "has no result")
        } catch {
            print(error.localizedDescription)
        }
        
    }
}
