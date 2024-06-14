//
//  HTTPAuthRepository.swift
//  Issue Solver
//
//  Created by ValehAmirov on 13.06.24.
//

import Foundation
import NetworkingPack


class HTTPAuthRepository {
    
    private var http: HTTPClient = .shared
    
    func register(body: RegisterModel) async throws -> ErrorModel? {
        do {
            return try await http.POST(endPoint: EndPoint.auth(.register).url, body: JSONConverter().encode(input: body)) 
        }
        catch {
            throw error
        }
    }
     
    
    func login(body: LoginModel) async throws -> ErrorModel? {
        do {
            return try await http.POST(endPoint: EndPoint.auth(.login).url, body: JSONConverter().encode(input: body))
        }
        catch {
            throw error
        }
    }  
    
    func confirmOTP(body: OTPModel) async throws -> ErrorModel? {
        do {
            return try await http.GET(endPoint: EndPoint.auth(.confirmOTP).url)
        }
        catch {
            throw error
        }
    }  
    
    func resendOTP(body: EmailModel) async throws -> ErrorModel? {
        do {
            return try await http.POST(endPoint: EndPoint.auth(.resendOTP).url, body: JSONConverter().encode(input: body))
        }
        catch {
            throw error
        }
    }
    
    func forgetPassword(body: EmailModel) async throws -> ErrorModel? {
        do {
            return try await http.POST(endPoint: EndPoint.auth(.forgetPassword).url, body: JSONConverter().encode(input: body))
        }
        catch {
            throw error
        }
    }
    
    func resetPassword(body: ResetPasswordModel) async throws -> ErrorModel? {
        do {
            return try await http.POST(endPoint: EndPoint.auth(.resetPassword).url, body: JSONConverter().encode(input: body))
        }
        catch {
            throw error
        }
    }
}
