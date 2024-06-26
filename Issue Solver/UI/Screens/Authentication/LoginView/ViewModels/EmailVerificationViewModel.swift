//
//  EmailVerificationViewModel.swift
//  Issue Solver
//
//  Created by ValehAmirov on 14.06.24.
//

import Foundation


class EmailVerificationViewModel: ObservableObject {
    
    private var authRepository = HTTPAuthRepository()

    @Published var emailText: String = "" {
        didSet {
            validateEmail()
        }
    }
    @Published var isRightEmail: Bool = true
    @Published var hasTouchedEmail: Bool = false
    @Published var emailError: String? = nil
    @Published var errorMessage: String = ""
    @Published var showAlert: Bool = false
    @Published var verificationSuccess: Bool = false
    
    func emailVerification() async {
        let item = EmailModel(email: emailText)
        authRepository.forgetPassword(body: item) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    print(success.message ?? "")
                    self.verificationSuccess = true
                case .failure(let error):
                    print(error.localizedDescription)
                    self.handleAPIEmailError(self.errorMessage)
                }
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
    }
    
    
    func handleAPIEmailError(_ string: String) {
            isRightEmail = false
            showAlert = true
            errorMessage = "Bu error API den gelmelidir"
    }
}
