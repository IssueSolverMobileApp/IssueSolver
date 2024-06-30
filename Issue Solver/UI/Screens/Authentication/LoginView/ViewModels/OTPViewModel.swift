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
    
    /// - 'errorText' is show all type of error
    @Published var errorText: String = ""
    
    @Published var emailModel: EmailModel?
    @Published var isChangePassword: Bool = false
    
    @Published var isOTPHasError: Bool = false
    @Published var navigateLoginView: Bool = false
    @Published var navigatePasswordChangeView: Bool = false
    
    
    private var authRepository = HTTPAuthRepository()
    
    init() {
        setTimer()
    }
    
    @MainActor
    func sendOTPTrust(completion: @escaping ((Result<Bool, Error>) -> Void)) async {
        let item  = OTPModel(otpCode: otpText)
        authRepository.otpTrust(body: item) { result in
            switch result {
            case .success(_):
                completion(.success(true))
            case .failure(let error):
                self.errorText = error.localizedDescription
                completion(.failure(error))
            }
        }
    }
    
    @MainActor
    func sendOTPConfirm(completion: @escaping (Bool) -> Void) async {
        let item  = OTPModel(otpCode: otpText)
        authRepository.confirmOTP(body: item) { result in
            switch result {
            case .success(_):
                completion(true)
            case .failure(let error):
                self.errorText = error.localizedDescription
            }
        }
    }
    
    func resendOTP(with email: EmailModel) {
        authRepository.resendOTP(body: email) { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let error):
                self.errorText = error.localizedDescription
            }
        }
    }
    
    func checkOTPCode(completion: @escaping (Bool) -> Void) {
        isLoading = true
        if isChangePassword  {
            Task {
                await sendOTPTrust { [ weak self ] result in
                    switch result {
                    case .success(_):
                        self?.isLoading = false
                        completion(true)
                    case .failure(let error):
                        self?.isLoading = false
                        print(error.localizedDescription)
                    }
                }
            }
        } else {
            Task {
                await sendOTPConfirm { success in
                    completion(success)
                }
            }
        }
    }
    
    func resendOTP() {
        isLoading = true
        if let emailModel {
            resendOTP(with: emailModel)
            setTimer()
            errorText = ""
            isLoading = false
        }
    }
    
    func setTimer() {
        timer = CountdownView { [ weak self ] in /// - When timer finishes, do something
            self?.isTimerFinished = true
        }
    }
}
