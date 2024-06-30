//
//  OTPViewModel.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 21.06.24.
//

import Foundation
import NetworkingPack

final class OTPViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    
    /// - We use optional here, as we open OTPView, timer will be set to nil
    /// - Also we need to reuse timer as much as we need, so we can set a new value 
    @Published var timer: CountdownView?
    @Published var isTimerFinished: Bool = false
    
    /// - 'errorText' is show all type of error
    @Published var errorText: String = ""
    @Published var isError: Bool = false
    
    @Published var emailModel: EmailModel?
    @Published var isChangePassword: Bool = false
    
    @Published var isOTPHasError: Bool = false
    @Published var navigateLoginView: Bool = false
    @Published var navigatePasswordChangeView: Bool = false
    
    @Published var otpCode: [String] = Array(repeating: "", count: Constants.numberOfOTPFields)
    
    private var authRepository = HTTPAuthRepository()
    
    init() {
        setTimer()
    }
    
    @MainActor
    func sendOTPTrust(completion: @escaping ((Result<Bool, Error>) -> Void)) async {
        let item = OTPModel(otpCode: otpCode.joined())
        authRepository.otpTrust(body: item) { result in
            switch result {
            case .success(_):
                completion(.success(true))
            case .failure(let error):
                self.errorText = error.localizedDescription
                self.isError = true
                completion(.failure(error))
            }
        }
    }
    
    @MainActor
    func sendOTPConfirm(completion: @escaping (Bool) -> Void) async {
        let item  = OTPModel(otpCode: otpCode.joined())
        authRepository.confirmOTP(body: item) { result in
            switch result {
            case .success(_):
                completion(true)
            case .failure(let error):
                self.isError = true
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
                self.isError = true
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
        setTimer()
        resendOTP(with: emailModel ?? EmailModel(email: nil))
        errorText = ""
        isTimerFinished = false
        otpCode = Array(repeating: "", count: Constants.numberOfOTPFields)
    }
    
    func setTimer() {
        timer = CountdownView { [ weak self ] in /// - When timer finishes, do something
            DispatchQueue.main.async {
                self?.isTimerFinished = true
                self?.timer = nil
            }
        }
    }
}
