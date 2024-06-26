//
//  LoginViewModel.swift
//  Issue Solver
//
//  Created by ValehAmirov on 14.06.24.
//

import Foundation

class LoginViewModel: ObservableObject {
    private var authRepository = HTTPAuthRepository()

    @Published var emailText: String = ""
    @Published var passwordText: String = ""
    @Published var errorMessage: String? = ""
    @Published var isRightTextField: Bool = true
    
    @MainActor
    func login() async {
        
        let item = LoginModel(email: emailText, password: passwordText)
        authRepository.login(body: item) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let result):
                print(result.message ?? "")
                UserDefaults.standard.accessToken = result.data?.accessToken
                UserDefaults.standard.refreshToken = result.data?.refreshToken
            case .failure(let error):
                self.makeErrorMessage(error.localizedDescription)
            }
        }
    }

    ///For showing error that comes from API
    func makeErrorMessage(_ string: String) {
            isRightTextField = false
            errorMessage = string
    }
}
