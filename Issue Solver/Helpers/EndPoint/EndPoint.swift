//
//  EndPoint.swift
//  Issue Solver
//
//  Created by ValehAmirov on 13.06.24.
//

import Foundation

enum EndPoint: EndPointProtocol {
    
    case auth(AuthEndPoint)
    
    var url: String {
        switch self {
        case .auth(let authEndPoint):
            return authEndPoint.url
        }
    }
}

enum AuthEndPoint: EndPointProtocol {
    
    case register
    case login
    case confirmOTP
    case resendOTP
    case forgetPassword
    case resetPassword
    case loginRefreshToken
    
    var url: String {
        switch self {
        case .register:
            return "\(baseURL)/Auths/register"
        case .login:
            return "\(baseURL)/Auths/login"
        case .confirmOTP:
            return "\(baseURL)/Auths/confirm-otp"
        case .resendOTP:
            return "\(baseURL)/Auths/resend-otp"
        case .forgetPassword:
            return "\(baseURL)/Auths/forget-password"
        case .resetPassword:
            return "\(baseURL)/Auths/reset-password"
        case .loginRefreshToken:
            return "\(baseURL)/Auths/login-refreshtoken"
        }
    }
}
