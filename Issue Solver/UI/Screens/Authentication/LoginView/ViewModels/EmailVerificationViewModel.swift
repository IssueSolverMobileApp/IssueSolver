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
    @Published var error: Error?
    
    func emailVerification(completion: @escaping ((Bool) -> Void)) async {
        let item = EmailModel(email: emailText)
        authRepository.forgetPassword(body: item) { result in
            switch result {
            case .success(_):
                completion(true)
            case .failure(let error):
                DispatchQueue.main.async { [ weak self ] in
                    self?.error = error
                }
                completion(false)
            }
        }
    }
}
