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
            return "\(baseURL)Auths/register"
        case .login:
            return "\(baseURL)Auths/login"
        case .confirmOTP:
            return "\(baseURL)Auths/confirm-otp"
        case .resendOTP:
            return "\(baseURL)Auths/resend-otp"
        case .forgetPassword:
            return "\(baseURL)Auths/forget-password"
        case .resetPassword:
            return "\(baseURL)Auths/reset-password"
        case .loginRefreshToken:
            return "\(baseURL)Auths/login-refreshtoken"
        case .trustOTP:
            return "\(baseURL)Auths/otp-trust"
        case .getMe:
            return "\(baseURL)Users/getme"
        }
    }
}
