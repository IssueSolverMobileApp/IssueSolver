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
    
    func login() async {
        let item = LoginModel(email: emailText, password: passwordText)
        do {
            let result = try await authRepository.login(body: item)
            print(result ?? "")
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
