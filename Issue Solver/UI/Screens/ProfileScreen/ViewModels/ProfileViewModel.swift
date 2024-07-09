//
//  ProfileViewModel.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 21.06.24.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    @Published var emailText: String
    @Published var fullNameText: String
    private var profileRepository = HTTPProfileRepository()
    
    init(emailText: String = "", fullNameText: String = "", profileRepository: HTTPProfileRepository = HTTPProfileRepository()) {
        self.emailText = emailText
        self.fullNameText = fullNameText
        self.profileRepository = profileRepository
    }

   @MainActor
    func getFullName() async {
        profileRepository.getme { [weak self] result in
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
