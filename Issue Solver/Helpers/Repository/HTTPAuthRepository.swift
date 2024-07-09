//
//  HTTPAuthRepository.swift
//  Issue Solver
//
//  Created by ValehAmirov on 14.06.24.
//

import Foundation
import NetworkingPack

final class HTTPAuthRepository {
    
    private var http: HTTPClient = .shared
    func register(body: RegisterModel, completion: @escaping (Result<SuccessModel, Error>) -> Void) {
        http.POST(endPoint: EndPoint.auth(.register), body: JSONConverter().encode(input: body)) { (data: SuccessModel?, error: Error?) in
              DispatchQueue.main.async {
                if let error {
                    completion(.failure(error))
                }
                if let data {
                    completion(.success(data))
                }
            }
        }
    }
    
    
    func login(body: LoginModel, completion: @escaping (Result<LoginSuccessModel, Error>) -> Void) {
        
        http.POST(endPoint: EndPoint.auth(.login), body: JSONConverter().encode(input: body)) { (data: LoginSuccessModel?, error: Error?) in
            DispatchQueue.main.async {
                if let error {
                    completion(.failure(error))
                }
                if let data {
                    completion(.success(data))
                }
            }
        }
    }
    
    func confirmOTP(body: OTPModel, completion: @escaping (Result<SuccessModel, Error>) -> Void) {
        http.POST(endPoint: EndPoint.auth(.confirmOTP), body: JSONConverter().encode(input: body)) { (data: SuccessModel?, error: Error?) in
            DispatchQueue.main.async {
                if let error {
                    completion(.failure(error))
                }
                if let data {
                    completion(.success(data))
                }
            }
        }
    }
    
    func otpTrust(body: OTPModel, completion: @escaping (Result<IDTokenSuccessModel, Error>) -> Void) {
        http.POST(endPoint: EndPoint.auth(.trustOTP), body: JSONConverter().encode(input: body)) { (data: IDTokenSuccessModel?, error: Error?) in
            DispatchQueue.main.async {
                if let error {
                    completion(.failure(error))
                }
                if let data {
                    completion(.success(data))
                }
            }
        }
    }
    
    func resendOTP(body: EmailModel, completion: @escaping (Result<SuccessModel, Error>) -> Void) {
        http.POST(endPoint: EndPoint.auth(.resendOTP), body: JSONConverter().encode(input: body)) { (data: SuccessModel?, error: Error?) in
            DispatchQueue.main.async {
                if let error {
                    completion(.failure(error))
                }
                if let data {
                    completion(.success(data))
                }
            }
        }
    }
    
    func forgetPassword(body: EmailModel, completion: @escaping (Result<SuccessModel, Error>) -> Void) {
        http.POST(endPoint: EndPoint.auth(.forgetPassword), body: JSONConverter().encode(input: body)) { (data: SuccessModel?, error: Error?) in
            if let error {
                completion(.failure(error))
            }
            if let data {
                completion(.success(data))
            }
        }
    }
    
    func resetPassword(body: ResetPasswordModel, completion: @escaping (Result<SuccessModel, Error>) -> Void) {
        http.POST(endPoint: EndPoint.auth(.resetPassword), body: JSONConverter().encode(input: body)) { (data: SuccessModel?, error: Error?) in
            if let error {
                completion(.failure(error))
            }
            if let data {
                completion(.success(data))
            }
        }
    }
    
    func getme(completion: @escaping (Result<ProfileSuccessModel, Error>) -> Void) {
        http.GET(endPoint: EndPoint.auth(.getMe)) { (data: ProfileSuccessModel?, error: Error?) in
            if let error {
                completion(.failure(error))
            }
            
            if let data {
                completion(.success(data))
            }
        }
    }
}
