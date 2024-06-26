//
//  OTPViewModel.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 21.06.24.
//

import Foundation

final class OTPViewModel: ObservableObject {
    
    @Published var otpText: String = ""
    
    private var authRepository = HTTPAuthRepository()
    
    
    func sendOTPTrust() async {
        let item  = OTPModel(otpCode: otpText)
        
        authRepository.otpTrust(body: item) { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func sendOTPConfirm() async {
        let item  = OTPModel(otpCode: otpText)
        
        authRepository.confirmOTP(body: item) { result in
            switch result {
            case .success(let success):
                print(success.message ?? "")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
