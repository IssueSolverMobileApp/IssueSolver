//
//  OTPViewModel.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 21.06.24.
//

import Foundation
import NetworkingPack

final class OTPViewModel: ObservableObject {
    
    @Published var otpText: String = ""
    @Published var isLoading: Bool = false
    
    /// - We use optional here, as we open OTPView, timer will be set to nil
    /// - Also we need to reuse timer many times, so we can set new value when we need
    @Published var timer: CountdownView?
    @Published var isTimerFinished: Bool = true
    
    private var authRepository = HTTPAuthRepository()
    
    init() {
        timer = CountdownView { [ weak self ] in /// - When timer finishes, do something
            self?.isTimerFinished = true
        }
    }
    
    func sendOTPTrust(completion: @escaping ((Result<Bool, Error>) -> Void)) async {
        let item  = OTPModel(otpCode: otpText)
        authRepository.otpTrust(body: item) { result in
            switch result {
            case .success(_):
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
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
    
    func resendOTP(with email: EmailModel) {
        authRepository.resendOTP(body: email) { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let error):
                print(error)
            }
        }
    }
}
