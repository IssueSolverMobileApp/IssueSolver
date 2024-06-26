//
//  LoginViewModel.swift
//  Issue Solver
//
//  Created by ValehAmirov on 14.06.24.
//

import Foundation

@MainActor
class LoginViewModel: ObservableObject {
    private var authRepository = HTTPAuthRepository()

    @Published var emailText: String = "" {
        didSet {
              if emailText.isEmpty {
                  isRightEmail = true
                  errorMessage = ""
              }
          }
      }
    @Published var passwordText: String = "" {
        didSet {
              if passwordText.isEmpty {
                  isRightPassword = true
                  errorMessage = nil
              }
          }
      }
    @Published var errorMessage: String? = ""
    @Published var isRightEmail: Bool = true
    @Published var isRightPassword: Bool = true
    
    
    @MainActor
    func login() async {
        
        let item = LoginModel(email: emailText, password: passwordText)
        authRepository.login(body: item) { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }
                switch result {
                case .success(let result):
                    print(result.message ?? "")
                    UserDefaults.standard.accessToken = result.data?.accessToken
                    UserDefaults.standard.refreshToken = result.data?.refreshToken
                case .failure(let error):
                    self.handleAPIEmailError(error.localizedDescription)
                }
            }
        }
    }

    ///For showing error that comes from API
    func handleAPIEmailError(_ error: String) {
           isRightEmail = false
           isRightPassword = false
            errorMessage = error
    }
}
