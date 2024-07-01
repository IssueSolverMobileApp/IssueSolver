//
//  PassowordChangeViewModel.swift
//  Issue Solver
//
//  Created by ValehAmirov on 14.06.24.
//

import Foundation

class PasswordChangeViewModel: ObservableObject {
    
    private var authRepository = HTTPAuthRepository()
    
    /// - For checking if text inside textfields is true or false in right time
    @Published var passwordText: String = "" {
        didSet {
            validatePassword() }
     }
    
    @Published var confirmPasswordText: String = "" {
    didSet {
        validateConfirmPassword() }
    }
    
    /// - For checking if textfield format is right or not
    @Published var isRightPassword: Bool = true
    @Published var isRightConfirmPassword: Bool = true
    
    /// - For making textfield color to red after touch, write and then  delete something
    @Published var hasTouchedPassword: Bool = false
    @Published var hasTouchedConfirmPassword: Bool = false
    
    /// - For showing specific error below every textfield
    @Published var passwordError: String? = nil
    @Published var confirmPasswordError: String? = nil
    
    /// - For showing specific error
    @Published var showAlert: Bool = false
    @Published var errorMessage: String = ""
    
    @Published var navigateToLoginView = false
    @Published var isLoading: Bool = false
   
    
    // MARK: - Fetcing Data
    @MainActor
    func updatePassword(completion: @escaping ((Result<Bool, Error>) -> Void)) async {
        let item = ResetPasswordModel(password: passwordText, confirmPassword: confirmPasswordText)
        
        authRepository.resetPassword(body: item) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    completion(.success(true))
    
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.handleAPIEmailError(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }
    }
    
    // MARK: - Local Validation Function for PasswordTextfield
    private func validatePassword() {
        if !passwordText.isEmpty {
            hasTouchedPassword = true
        }
        
        if hasTouchedPassword {
            if passwordText.isEmpty {
                passwordError = "Şifrə boş ola bilməz"
                isRightPassword = false
            } else if !passwordText.isValidCharacterCount {
                passwordError = "Şifrə ən azı 8 simvoldan ibarət olmalıdır"
                isRightPassword = false
            } else if !passwordText.isValidPassword {
                passwordError = "Şifrədə ən azı bir böyük latın hərfi, bir kiçik latın hərfi, simvol və rəqəm istifadə olunmalıdır"
                isRightPassword = false
            } else {
                passwordError = nil
                isRightPassword = true
            }
        }
    }
    
    // MARK: - Local Validation Function for ConfirmPasswordTextfield
    private func validateConfirmPassword() {
        if !confirmPasswordText.isEmpty {
            hasTouchedConfirmPassword = true
        }
        if hasTouchedConfirmPassword {
            if confirmPasswordText.isEmpty {
                confirmPasswordError = "Şifrənin təsdiqi boş ola bilməz"
                isRightConfirmPassword = false
            } else if confirmPasswordText != passwordText {
                confirmPasswordError = "Hər iki şifrə eyni olmalıdır"
                isRightConfirmPassword = false
            } else {
                confirmPasswordError = nil
                isRightConfirmPassword = true
            }
        }
    }
    
    // MARK: - For Showing Error that Comes From API
    private func handleAPIEmailError(_ error: String) {
        self.errorMessage = error
        showAlert = true
    }
}
