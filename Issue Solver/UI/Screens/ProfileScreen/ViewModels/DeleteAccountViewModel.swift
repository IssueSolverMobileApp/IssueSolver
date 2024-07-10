//
//  DeleteAccountViewModel.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 23.06.24.
//

import Foundation
import NetworkingPack

class DeleteAccountViewModel: ObservableObject {
    
    private var profileRepository = HTTPProfileRepository()
    
    @Published var passwordText = "" {
        didSet {
            validatePassword()
            }
        }
    @Published var isRightPassword: Bool = true
    @Published var hasTappedPassword = false
    @Published var passwordError: String? = nil
    @Published var isLoading: Bool = false
    
    func deleteAccount(with router: Router) {
        isLoading = true
        
        let item = PasswordModel(password: passwordText)
        profileRepository.deleteAccount(body: item) { [weak self] result in
            guard let self else { return }
            isLoading = false
            
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    router.popToRoot()
                    print(result.message ?? "")
                case .failure(let error):
                    self.handleAPIEmailError(error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Local Validation Function for FullNameTextfield
    private func validatePassword() {
        if !passwordText.isEmpty {
            hasTappedPassword = true
        }
        if hasTappedPassword {
            if passwordText.isEmpty {
                passwordError = "Şifrə boş ola bilməz"
                isRightPassword = false
            } else {
                passwordError = nil
                isRightPassword = true
            }
        }
    }
    
    // MARK: - For Showing Error that Comes From API
    func handleAPIEmailError(_ error: String) {
           isRightPassword = false
            passwordError = error
    }
}
