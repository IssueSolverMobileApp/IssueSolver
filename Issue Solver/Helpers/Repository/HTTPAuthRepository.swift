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
    
    func register(body: RegisterModel) async throws -> EncodeRegister {
        do {
            return try await http.POST(endPoint: EndPoint.auth(.register).url, body: JSONConverter().encode(input: body)) 
        }
        catch {
            throw error
        }
    }
     
    
    func login() async throws -> LoginModel? {
        do {
            return try await http.GET(endPoint: EndPoint.auth(.login).url)
        }
        catch {
            throw error
        }
    }  
    
    func confirmOTP() async throws -> OTPModel? {
        do {
            return try await http.GET(endPoint: EndPoint.auth(.confirmOTP).url)
        }
        catch {
            throw error
        }
    }  
    
    func resendOTP() async throws -> EmailModel? {
        do {
            return try await http.GET(endPoint: EndPoint.auth(.resendOTP).url)
        }
        catch {
            throw error
        }
    }
}
