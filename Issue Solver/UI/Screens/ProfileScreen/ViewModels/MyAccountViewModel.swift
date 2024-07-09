//
//  MyAccountViewModel.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 23.06.24.
//

import Foundation

class MyAccountViewModel: ObservableObject {
    
    private var profileRepository = HTTPProfileRepository()
    
    @Published var fullNameText = "" {
        didSet {
            validateFullName()
        }
    }
    @Published var emailText = ""
    @Published var hasTappedFullName = false
    @Published var isRightFullName: Bool = true
    @Published var fullNameError: String? = nil
    

     func getUserInfo() {
         profileRepository.getMe { [weak self] result in
             guard let self = self else { return }
             DispatchQueue.main.async {
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
    
    func updateUserFullName(with router: Router) {
        let item = FullNameModel(fullName: fullNameText)
        profileRepository.changeFullName(body: item) { [weak self] result in
            guard self != nil else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    router.dismissView()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Local Validation Function for FullNameTextfield
    private func validateFullName() {
        if !fullNameText.isEmpty {
            hasTappedFullName = true
        }
        if hasTappedFullName {
            if fullNameText.isEmpty {
                fullNameError = "Ad, Soyad boş ola bilməz"
                isRightFullName = false
            } else {
                fullNameError = nil
                isRightFullName = true
            }
        }
    }
}
