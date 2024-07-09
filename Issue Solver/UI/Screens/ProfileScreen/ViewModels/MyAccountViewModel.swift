//
//  MyAccountViewModel.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 23.06.24.
//

import Foundation

class MyAccountViewModel: ObservableObject {
    
    private var authRepository = HTTPAuthRepository()
    
    @Published var fullNameText = "" {
        didSet {
            validateFullName()
        }
    }
    @Published var emailText = ""
    @Published var hasTappedFullName = false
    @Published var isRightFullName: Bool = true
    @Published var fullNameError: String? = nil
    
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
