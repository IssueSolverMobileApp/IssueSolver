//
//  RegisterViewModel.swift
//  Issue Solver
//
//  Created by ValehAmirov on 20.06.24.
//

import Foundation

class RegisterViewModel: ObservableObject {
    
    private var authRepository = HTTPAuthRepository()
    
    @Published var fullNameText: String = ""  {
        didSet {
            validateFullName()
        }
    }
        
    @Published var emailText: String = "" {
        didSet {
            validateEmail()
        }
    }
    @Published var passwordText: String = ""
    {
        didSet {
            validatePassword()
        }
    }
    @Published var confirmPasswordText: String = "" {
        didSet {
            validateConfirmPassword()
        }
    }
    
    ///For checking if textfield format is right or not
    @Published var isRightFullName: Bool = true
    @Published var isRightEmail: Bool = true
    @Published var isRightPassword: Bool = true
    @Published var isRightConfirmEmail: Bool = true
    @Published var isRightFields: Bool = false
    
    ///For making textfield color to red after touch, write and then  delete something
    @Published var hasTouchedFullName: Bool = false
    @Published var hasTouchedEmail: Bool = false
    @Published var hasTouchedPassword: Bool = false
    @Published var hasTouchedConfirmPassword: Bool = false
    
    ///For showing specific error below every textfield
    @Published var emailError: String? = nil
    @Published var passwordError: String? = nil
    @Published var confirmPasswordError: String? = nil
    @Published var fullNameError: String? = nil
        
    
    
    func register(completion: @escaping (Bool) -> Void) async {
        let item = RegisterModel(email: emailText, fullName: fullNameText, password: passwordText, confirmPassword: confirmPasswordText)
        authRepository.register(body: item) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let result):
                completion(result.success ?? false)
            case .failure(let error):
                handleAPIEmailError(error.localizedDescription)
            }
        }
    }
    
    ///Full name  local validation function
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
    
    ///Email local validation function
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
        
        if isRightEmail && isRightPassword && isRightFullName && isRightConfirmEmail {
            isRightFields = true
        } else {
            isRightFields = false
        }
    }
    
    ///Password local validation function
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
        
        if isRightEmail && isRightPassword && isRightFullName && isRightConfirmEmail {
            isRightFields = true
        } else {
            isRightFields = false
        }

    }
    
    ///Confirm password local validation function
    private func validateConfirmPassword() {
        if !confirmPasswordText.isEmpty {
            hasTouchedConfirmPassword = true
        }
        if hasTouchedConfirmPassword {
            if confirmPasswordText.isEmpty {
                confirmPasswordError = "Şifrənin təsdiqi boş ola bilməz"
                isRightConfirmEmail = false
            } else if confirmPasswordText != passwordText {
                confirmPasswordError = "Hər iki şifrə eyni olmalıdır"
                isRightConfirmEmail = false
            } else {
                confirmPasswordError = nil
                isRightConfirmEmail = true
            }
        }
        if isRightEmail && isRightPassword && isRightFullName && isRightConfirmEmail {
            isRightFields = true
        } else {
            isRightFields = false
        }

    }
    
    /// Email error that comes from API
    private func handleAPIEmailError(_ error: String) {
        self.emailError = error
        self.isRightEmail = false
    }
}
