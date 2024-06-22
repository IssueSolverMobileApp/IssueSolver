//
//  HTTPAuthRepository.swift
//  Issue Solver
//
//  Created by ValehAmirov on 14.06.24.
//

import Foundation
import NetworkingPack

class HTTPAuthRepository {
    
    private var http: HTTPClient = .shared
    
    func register(body: RegisterModel) async throws -> SuccessModel? {
        do {
            return try await http.POST(endPoint: EndPoint.auth(.register), body: JSONConverter().encode(input: body))
        }
        catch {
            throw error
        }
    }
     
    
    func login(body: LoginModel) async throws -> LoginSuccessModel? {
        do {
            return try await http.POST(endPoint: EndPoint.auth(.login), body: JSONConverter().encode(input: body))
        }
        catch {
            throw error
        }
    }
    
    func confirmOTP(body: OTPModel) async throws -> SuccessModel? {
        do {
            return try await http.GET(endPoint: EndPoint.auth(.confirmOTP))
        }
        catch {
            throw error
        }
    }
    
    func otpTrust(body: OTPModel) async throws -> IDTokenSuccessModel? {
        do {
            return try await http.POST(endPoint: EndPoint.auth(.trustOTP), body: JSONConverter().encode(input: body))
        }
        catch {
            throw error
        }
        
    }
    
    func resendOTP(body: EmailModel) async throws -> SuccessModel? {
        do {
            return try await http.POST(endPoint: EndPoint.auth(.resendOTP), body: JSONConverter().encode(input: body))
        }
        catch {
            throw error
        }
    }
    
    func forgetPassword(body: EmailModel) async throws -> SuccessModel? {
        do {
            return try await http.POST(endPoint: EndPoint.auth(.forgetPassword), body: JSONConverter().encode(input: body))
        }
        catch {
            throw error
        }
    }
    
    func resetPassword(body: ResetPasswordModel) async throws -> SuccessModel? {
        do {
            return try await http.POST(endPoint: EndPoint.auth(.resetPassword), body: JSONConverter().encode(input: body))
        }
        catch {
            throw error
        }
    }
}
