//
//  ProfileViewModel.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 21.06.24.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    @Published var emailText: String = ""
    @Published var fullNameText: String = ""
    private var profileRepository = HTTPProfileRepository()

   @MainActor
    func getFullName() async {
        profileRepository.getme { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                self.fullNameText = result.data?.fullName ?? ""
                self.emailText = result.data?.email ?? ""
                print(result.data?.fullName ?? "")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
