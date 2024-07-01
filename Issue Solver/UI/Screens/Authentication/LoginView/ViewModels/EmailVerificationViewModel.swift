//
//  EmailVerificationViewModel.swift
//  Issue Solver
//
//  Created by ValehAmirov on 14.06.24.
//

import Foundation

@MainActor
class EmailVerificationViewModel: ObservableObject {
    
    private var authRepository = HTTPAuthRepository()
    
    /// - For checking if text inside textfield is true or false in right time
    @Published var emailText: String = "" {
        didSet {
            validateEmail()
            if emailText.isEmpty {
                isRightEmail = true
                emailError = "" }
        }
    }
    /// - For checking if textfield format is right or not
    @Published var isRightEmail: Bool = true
    
    /// - For making textfield color to red after touch, write and then  delete something
    @Published var hasTouchedEmail: Bool = false
    
    /// - For showing specific error
    @Published var emailError: String? = nil
    @Published var errorMessage: String = ""
    @Published var showAlert: Bool = false
    
    @Published var verificationSuccess = false
    @Published var navigateOTPView = false
    @Published var isLoading: Bool = false
    
    // MARK: - Fetcing Data
    func emailVerification(completion: @escaping ((Bool) -> Void)) async {
        isLoading = true
        let item = EmailModel(email: emailText)
        authRepository.forgetPassword(body: item) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(_):
                    completion(true)
                case .failure(let error):
                    self?.handleAPIEmailError(error.localizedDescription)
                    completion(false)
                }
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
    }
    
    // MARK: - For Showing Email Error That Comes from API
    func handleAPIEmailError(_ string: String) {
        isRightEmail = false
        showAlert = true
        emailError = string
    }
}
