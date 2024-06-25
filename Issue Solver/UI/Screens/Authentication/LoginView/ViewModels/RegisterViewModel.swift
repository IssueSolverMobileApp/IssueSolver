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
    @Published var emailError: String? = nil
    @Published var passwordError: String? = nil
    @Published var confirmPasswordError: String? = nil
    @Published var fullNameError: String? = nil
    @Published var isRightFullName: Bool = true
    @Published var isRightEmail: Bool = true
    @Published var isRightPassword: Bool = true
    @Published var isRightConfirmEmail: Bool = true
    
    func register(completion: @escaping (Bool) -> Void) async {
        let item = RegisterModel(email: emailText, fullName: fullNameText, password: passwordText, confirmPassword: confirmPasswordText)
        do {
            let result = try await authRepository.register(body: item)
            completion(result?.success ?? false)
            //navigateOTPView = result?.success ?? false
            print(result ?? "has no result")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func validateFullName() {
        isRightFullName = false
           fullNameError = fullNameText.isEmpty ? "Ad, Soyad boş ola bilməz" : nil
       }
    
    private func validateEmail() {
            emailError = nil
            isRightEmail = false
            if emailText.isEmpty {
                emailError = "E-poçt boş ola bilməz"
            } else if !emailText.isValidEmail {
                emailError = "E-poçt formatı doğru deyil"
            }
        }
        
        private func validatePassword() {
            passwordError = nil
            isRightPassword = false
            if passwordText.isEmpty {
                passwordError = "Şifrə boş ola bilməz"
            } else if !passwordText.isValidCharacterCount {
                passwordError = "Şifrə ən azı 8 simvoldan ibarət olmalıdır"
            } else if !passwordText.isValidPassword {
                passwordError = "Şifrədə ən azı bir böyük latın hərfi, bir kiçik latın hərfi, simvol və rəqəm istifadə olunmalıdır"
            }
        }
        
        private func validateConfirmPassword() {
            confirmPasswordError = nil
            isRightConfirmEmail = false
            if confirmPasswordText.isEmpty {
                confirmPasswordError = "Şifrənin təsdiqi boş ola bilməz"
            } else if confirmPasswordText != passwordText {
                confirmPasswordError = "Hər iki şifrə eyni olmalıdır"
            }
        }
}
