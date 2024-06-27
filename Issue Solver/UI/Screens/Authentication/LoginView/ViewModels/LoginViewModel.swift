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
            isRightEmail = true
            errorMessage = ""
        }
    }
    @Published var passwordText: String = "" {
        didSet {
            isRightPassword = true
            errorMessage = ""
        }
    }
    @Published var errorMessage: String? = ""
    @Published var isRightEmail: Bool = true
    @Published var isRightPassword: Bool = true
    
    @MainActor
    func login() async {
        
        let item = LoginModel(email: emailText, password: passwordText)
        authRepository.login(body: item) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let result):
                print(result.message ?? "")
//                UserDefaults.standard.accessToken = result.data?.accessToken
//                UserDefaults.standard.refreshToken = result.data?.refreshToken
            case .failure(let error):
                self.makeErrorMessage(error.localizedDescription)
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
