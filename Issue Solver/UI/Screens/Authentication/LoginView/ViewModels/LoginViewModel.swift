//
//  LoginViewModel.swift
//  Issue Solver
//
//  Created by ValehAmirov on 14.06.24.
//

import Foundation
import NetworkingPack

@MainActor
class LoginViewModel: ObservableObject {
    private var authRepository = HTTPAuthRepository()
    
    /// - For checking if text inside textfields is true or false in right time
    @Published var emailText: String = "" {
        didSet {
            if emailText.isEmpty {
                isRightEmail = true
                errorMessage = "" }
        }
    }
    @Published var passwordText: String = "" {
        didSet {
            if passwordText.isEmpty {
                isRightPassword = true
                errorMessage = "" }
        }
    }
    /// - For navigating other views
    @Published var navigateToEmailVerificationView = false
    @Published var navigateToRegisterView = false
    @Published var navigateToProfileView = false
    
    /// - Variables for checking error cases
    @Published var errorMessage: String? = ""
    @Published var isRightEmail: Bool = true
    @Published var isRightPassword: Bool = true
    @Published var loginSuccess: Bool = false
    @Published var isLoading: Bool = false
    
    
    // MARK: - Fetching Data
    func login(completion: @escaping (Bool) -> Void) async {
        isLoading = true
        
        let item = LoginModel(email: emailText, password: passwordText)
        authRepository.login(body: item) { [weak self] result in
            guard let self else { return }
                self.isLoading = false
            
                switch result {
                case .success(_):
                    completion(true)
                case .failure(let error):
                    if error.localizedDescription == "409" {
                        completion(false)
                    } else {
                        self.handleAPIEmailError(error.localizedDescription)
                }
            }
        }
    }

    // MARK: - For Showing Error that Comes From API
    func handleAPIEmailError(_ error: String) {
            isRightEmail = false
            isRightPassword = false
            errorMessage = error
    }
 }
