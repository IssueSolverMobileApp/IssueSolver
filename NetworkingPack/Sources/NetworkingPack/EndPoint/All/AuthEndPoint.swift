//
//  AuthEndPoint.swift
//  
//
//  Created by Valeh Amirov on 04.07.24.
//

import Foundation

public enum AuthEndPoint: EndPointProtocol {
    
    case register
    case login
    case confirmOTP
    case resendOTP
    case forgetPassword
    case resetPassword
    case loginRefreshToken
    case trustOTP
    case getMe
    
    var url: String {
        switch self {
        case .register:
            return "\(baseURL)api/Auths/register"
        case .login:
            return "\(baseURL)api/Auths/login"
        case .confirmOTP:
            return "\(baseURL)api/Auths/confirm-otp"
        case .resendOTP:
            return "\(baseURL)api/Auths/resend-otp"
        case .forgetPassword:
            return "\(baseURL)api/Auths/forget-password"
        case .resetPassword:
            return "\(baseURL)api/Auths/reset-password"
        case .loginRefreshToken:
            return "\(baseURL)api/Auths/login-refreshtoken"
        case .trustOTP:
            return "\(baseURL)api/Auths/otp-trust"
        case .getMe:
            return "\(baseURL)api/Users/getme"
        }
    }
}
