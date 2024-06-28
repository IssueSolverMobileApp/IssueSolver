//
//  LoginViewModel.swift
//  Issue Solver
//
//  Created by ValehAmirov on 14.06.24.
//

import Foundation
//import NetworkingPack

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
                errorMessage = ""
            }
        }
    }
    @Published var errorMessage: String? = ""
    @Published var isRightEmail: Bool = true
    @Published var isRightPassword: Bool = true
    @Published var isLoading: Bool = false
    @Published var navigateOTPView = false
    
    func login() async {
        isLoading = true
        
        let item = LoginModel(email: emailText, password: passwordText)
        authRepository.login(body: item) { [weak self] result in
            guard let self else { return }
            
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let result):
                    print(result.message ?? "")
                    
                case .failure(let error):
                    if error.localizedDescription == "409" {
                        self.navigateOTPView = true
                    } else {
                        self.makeErrorMessage(error.localizedDescription)
                    }
                }
            }
        }
    }

    ///For showing error that comes from API
    func makeErrorMessage(_ string: String) {
            isRightEmail = false
            isRightPassword = false
            errorMessage = string
    }
  
    func getMe() {
        let token = UserDefaults.standard.accessToken
        print(token ?? "" + "--------------------------")
        authRepository.getme { result in
            switch result {
            case .success(let success):
                print(success.fullName ?? "sehv")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
