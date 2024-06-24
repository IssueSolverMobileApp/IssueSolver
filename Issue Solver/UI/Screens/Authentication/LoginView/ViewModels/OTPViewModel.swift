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
        do {
            let result = try await authRepository.otpTrust(body: item)
            print(result ?? "")
        }
        catch {
            print(error.localizedDescription)
        }
    }  
    
    func sendOTPConfirm() async {
        let item  = OTPModel(otpCode: otpText)
        print(item)
        do {
            let result = try await authRepository.confirmOTP(body: item)
            print(result ?? "")
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
