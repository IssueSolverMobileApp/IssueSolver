//
//  EmailVerificationViewModel.swift
//  Issue Solver
//
//  Created by ValehAmirov on 14.06.24.
//

import Foundation


class EmailVerificationViewModel: ObservableObject {
    
    private var authRepository = HTTPAuthRepository()

    @Published var emailText: String = ""
    
    func emailVerification() async {
        let item = EmailModel(email: emailText)
        authRepository.forgetPassword(body: item) { result in
            switch result {
            case .success(let success):
                print(success.message ?? "")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
