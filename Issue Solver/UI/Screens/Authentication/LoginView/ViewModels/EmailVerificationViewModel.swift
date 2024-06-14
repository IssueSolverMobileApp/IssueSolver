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
        do {
            let result = try await authRepository.forgetPassword(body: item)
            print(result ?? "")
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
