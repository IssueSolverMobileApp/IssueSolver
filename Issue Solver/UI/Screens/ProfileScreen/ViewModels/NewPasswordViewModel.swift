//
//  NewPasswordViewModel.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 23.06.24.
//

import Foundation

class NewPasswordViewModel: ObservableObject {
    
    private var profileRepository = HTTPProfileRepository()
    
    /// - For checking if text inside textfields is true or false in right time
    @Published var currentPasswordText = "" {
        didSet {
            validateCurrentPassword() }
    }
    @Published var newPasswordText = "" {
        didSet {
            validateNewPassword() }
    }
    @Published var confirmPasswordText = "" {
        didSet {
            validateConfirmPassword() }
    }
    
    /// - For checking if textfield format is right or not
    @Published var isRightCurrentPassword: Bool = true
    @Published var isRightNewPassword: Bool = true
    @Published var isRightConfirmPassword: Bool = true
    @Published var isRightFields: Bool = false
    
    /// - For making textfield color to red after touch, write and then  delete something
    @Published var hasTappedCurrentPassword: Bool = false
    @Published var hasTappedNewPassword: Bool = false
    @Published var hasTappedConfirmPassword: Bool = false
    
    /// - For showing specific error below every textfield
    @Published var currentPasswordError: String? = nil
    @Published var newPasswordError: String? = nil
    @Published var confirmPasswordError: String? = nil
    
    
    func updateUserPassword(with router: Router) {
        let item = UpdatePasswordModel(currentPassword: currentPasswordText, password: newPasswordText, confirmPassword: confirmPasswordText)
        profileRepository.changePassword(body: item) { [weak self] result in
            guard self != nil else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    router.dismissView()
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.handleAPIEmailError(error.localizedDescription)
                }
            }
        }
    }
    // MARK: - Local Validation Function for CurrentPasswordTextfield
    private func validateCurrentPassword() {
        if !currentPasswordText.isEmpty {
            hasTappedCurrentPassword = true
        }
        if hasTappedCurrentPassword {
            if currentPasswordText.isEmpty {
                currentPasswordError = "Cari şifrə boş ola bilməz"
                isRightCurrentPassword = false
            }else {
                currentPasswordError = nil
                isRightCurrentPassword = true
            }
        }
        if isRightCurrentPassword && isRightNewPassword && isRightConfirmPassword {
            isRightFields = true
        } else {
            isRightFields = false
        }
    }
    
    // MARK: - Local Validation Function for NewPasswordTextfield
    private func validateNewPassword() {
        if !newPasswordText.isEmpty {
            hasTappedNewPassword = true
        }
        if hasTappedNewPassword {
            if newPasswordText.isEmpty {
                newPasswordError = "Yeni şifrə boş ola bilməz"
                isRightNewPassword = false
            } else if !newPasswordText.isValidCharacterCount {
                newPasswordError = "Şifrə ən azı 8 simvoldan ibarət olmalıdır"
                isRightNewPassword = false
            } else if !newPasswordText.isValidPassword {
                newPasswordError = "Şifrədə ən azı bir böyük latın hərfi, bir kiçik latın hərfi, simvol və rəqəm istifadə olunmalıdır"
                isRightNewPassword = false
            } else if  !confirmPasswordText.isEmpty && newPasswordText != confirmPasswordText {
                confirmPasswordError = "Hər iki şifrə eyni olmalıdır"
                isRightConfirmPassword = false
            } else {
                newPasswordError = nil
                isRightNewPassword = true
            }
        }
        
        if isRightCurrentPassword && isRightNewPassword && isRightConfirmPassword {
            isRightFields = true
        } else {
            isRightFields = false
        }
    }
    
    // MARK: - Local Validation Function for ConfirmPasswordTextfield
    private func validateConfirmPassword() {
        if !confirmPasswordText.isEmpty {
            hasTappedConfirmPassword = true
        }
        if hasTappedConfirmPassword {
            if confirmPasswordText.isEmpty {
                confirmPasswordError = "Şifrənin təsdiqi boş ola bilməz"
                isRightConfirmPassword = false
            } else if confirmPasswordText != newPasswordText {
                confirmPasswordError = "Hər iki şifrə eyni olmalıdır"
                isRightConfirmPassword = false
            } else {
                confirmPasswordError = nil
                isRightConfirmPassword = true
            }
        }
        if isRightCurrentPassword && isRightNewPassword && isRightConfirmPassword {
            isRightFields = true
        } else {
            isRightFields = false
        }
    }
    
    // MARK: - For Showing Error that Comes From API
    private func handleAPIEmailError(_ error: String) {
        self.currentPasswordError = error
        self.isRightCurrentPassword = false
    }
    
}
