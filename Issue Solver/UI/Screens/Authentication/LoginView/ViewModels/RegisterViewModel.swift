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
    @Published  var errorMessage = ""
    @Published  var isShowingError = false
    @Published  var isLoading = false
    @Published  var isRightField = true
    @Published  var isUserLoggedIn = false
    
    func register() async {
        let item = RegisterModel(email: emailText, fullName: fullNameText, password: passwordText, confirmPassword: confirmPasswordText)
        do {
            let result = try await authRepository.register(body: item)
            print(result ?? "has no result")
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func register() {
            isLoading = true
            
            if emailText.isEmpty  && passwordText.isEmpty {
                makeErrorMessage("Email və şifrə boş ola bilməz.")
                return
            }
            
            if emailText.isEmpty {
                makeErrorMessage("Email boş ola bilməz.")
                return
            }
            
            if passwordText.isEmpty {
                makeErrorMessage("Şifrə boş ola bilməz.")
                return
            }
            
            if !emailText.isValidEmail {
                makeErrorMessage("Email doğru deyil.")
                return
            }
            
            if !passwordText.isValidPassword {
                makeErrorMessage("Şifrə doğru deyil.")
                return
                
            }
        }

            func makeErrorMessage(_ string: String) {
                errorMessage = string
                isShowingError = true
                isLoading = false
                isRightField = false
            }

            func resetErrorState() {
                isRightField = true
                isShowingError = false
    }
}
