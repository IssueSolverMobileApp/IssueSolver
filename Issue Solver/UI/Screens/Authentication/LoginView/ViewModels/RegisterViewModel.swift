//
//  RegisterViewModel.swift
//  Issue Solver
//
//  Created by ValehAmirov on 20.06.24.
//

import Foundation

@MainActor
class RegisterViewModel: ObservableObject {
    
    private var authRepository = HTTPAuthRepository()
    
    /// - For checking if text inside textfields is true or false in right time
    @Published var fullNameText: String = ""  {
        didSet {
            validateFullName() }
    }
    
    @Published var emailText: String = "" {
        didSet {
            validateEmail() }
    }
    
    @Published var passwordText: String = "" {
        didSet {
            validatePassword() }
    }
    
    @Published var confirmPasswordText: String = "" {
        didSet {
            validateConfirmPassword() }
    }
    
    /// - For checking if textfield format is right or not
    @Published var isRightFullName: Bool = true
    @Published var isRightEmail: Bool = true
    @Published var isRightPassword: Bool = true
    @Published var isRightConfirmPassword: Bool = true
    @Published var isRightFields: Bool = false
    
    /// - For making textfield color to red after touch, write and then  delete something
    @Published var hasTouchedFullName: Bool = false
    @Published var hasTouchedEmail: Bool = false
    @Published var hasTouchedPassword: Bool = false
    @Published var hasTouchedConfirmPassword: Bool = false
    
    /// - For showing specific error below every textfield
    @Published var emailError: String? = nil
    @Published var passwordError: String? = nil
    @Published var confirmPasswordError: String? = nil
    @Published var fullNameError: String? = nil
    
    /// - For navigating to other views
    @Published var navigateOTPView: Bool = false
    @Published var isChecked: Bool = false
    @Published var showCheckboxError: Bool = false
    
    @Published var isLoading: Bool = false
    
    
    // MARK: - Fetching Data
    func register(completion: @escaping (Bool) -> Void) async {
        isLoading = true
        
        let item = RegisterModel(email: emailText, fullName: fullNameText, password: passwordText, confirmPassword: confirmPasswordText)
        authRepository.register(body: item) { [weak self] result in
            self?.isLoading = false
            
            switch result {
            case .success(let result):
                completion(result.success ?? false)
            case .failure(let error):
                self?.handleAPIEmailError(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Local Validation Function for FullNameTextfield
    private func validateFullName() {
        if !fullNameText.isEmpty {
            hasTouchedFullName = true
        }
        if hasTouchedFullName {
            if fullNameText.isEmpty {
                fullNameError = "Ad, Soyad boş ola bilməz"
                isRightFullName = false
            } else {
                fullNameError = nil
                isRightFullName = true
            }
        }
    }
    
    // MARK: - Local Validation Function for EmailTextfield
    private func validateEmail() {
        if !emailText.isEmpty {
            hasTouchedEmail = true
        }
        
        if hasTouchedEmail {
            if emailText.isEmpty {
                emailError = "E-poçt boş ola bilməz"
                isRightEmail = false
            } else if !emailText.isValidEmail {
                emailError = "E-poçt formatı doğru deyil"
                isRightEmail = false
            }
            else {
                emailError = nil
                isRightEmail = true
            }
        }
        /// - We can use isRightTextField when all textfields is true
        if isRightEmail && isRightPassword && isRightFullName && isRightConfirmPassword {
            isRightFields = true
        } else {
            isRightFields = false
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
            } else if  !confirmPasswordText.isEmpty && passwordText != confirmPasswordText {
                confirmPasswordError = "Hər iki şifrə eyni olmalıdır"
                isRightConfirmPassword = false
            } else {
                passwordError = nil
                isRightPassword = true
            }
        }
        
        if isRightEmail && isRightPassword && isRightFullName && isRightConfirmPassword {
            isRightFields = true
        } else {
            isRightFields = false
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
        if isRightEmail && isRightPassword && isRightFullName && isRightConfirmPassword {
            isRightFields = true
        } else {
            isRightFields = false
        }
    }
    
    // MARK: - For Showing Error that Comes From API
    private func handleAPIEmailError(_ error: String) {
        self.emailError = error
        self.isRightEmail = false
    }
}
