//
//  LoginViewModel.swift
//  Issue Solver
//
//  Created by ValehAmirov on 14.06.24.
//

import Foundation

class LoginViewModel: ObservableObject {
    private var authRepository = HTTPAuthRepository()
    
    @Published var emailText: String = ""
    @Published var passwordText: String = ""
    @Published  var errorMessage: String?
    @Published  var isShowingError = false
    @Published  var isLoading = false
    @Published  var isRightField = true
    @Published  var isUserLoggedIn = false
    
    func login() async {
        let item = LoginModel(email: emailText, password: passwordText)
        do {
            let result = try await authRepository.login(body: item)
            print(result ?? "")
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func loginError() {
            isLoading = true
            
            if !emailText.isValidEmail {
                makeErrorMessage("Email doğru deyil.")
            }
            
            if !passwordText.isValidPassword {
                makeErrorMessage("Şifrə doğru deyil.")
                
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
