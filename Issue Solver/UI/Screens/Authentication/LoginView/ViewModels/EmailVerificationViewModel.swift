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
//    @Published var error: Error?
    
    func emailVerification(completion: @escaping ((Bool) -> Void)) async {
        let item = EmailModel(email: emailText)
        authRepository.forgetPassword(body: item) { result in
            switch result {
            case .success(_):
                completion(true)
            case .failure(let error):
                DispatchQueue.main.async { [ weak self ] in
                    guard let self else { return }
//                    self.error = error
                    handleAPIEmailError(error.localizedDescription)
                }
                completion(false)
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
            emailError = string
    }
}
