//
//  ProfileViewModel.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 21.06.24.
//

import Foundation

class ProfileViewModel: ObservableObject {
    private var profileRepository = HTTPProfileRepository()
    @Published var emailText: String = ""
    @Published var fullNameText: String = ""
    @Published var showExitAccountAlert = false
    @Published var showDeleteAccountAlert = false
    
    let aboutApp = URL(string: "https://issue-solver.vercel.app/dashboard/about") 
    let questions = URL(string: "https://issue-solver.vercel.app/dashboard/faq")
    let terms = URL(string: "https://issue-solver.vercel.app/dashboard/privacy")


    func getFullName() {
        profileRepository.getMe { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    self.fullNameText = result.data?.fullName ?? ""
                    self.emailText = result.data?.email ?? ""
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
