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
            if passwordText.isEmpty {
                isRightPassword = true
                errorMessage = "" }
        }
    }
    @Published var errorMessage: String? = ""
    @Published var isRightPassword: Bool = true
    
    @MainActor
    func deleteAccount(with router: Router) async {
        let item = PasswordModel(password: passwordText)
        profileRepository.deleteAccount(body: item) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let result):
                router.popToRoot()
                print(result.message ?? "")
            case .failure(let error):
                self.handleAPIEmailError(error.localizedDescription)
            }
        }
    }
    
    // MARK: - For Showing Error that Comes From API
    func handleAPIEmailError(_ error: String) {
           isRightPassword = false
            errorMessage = error
    }
}
