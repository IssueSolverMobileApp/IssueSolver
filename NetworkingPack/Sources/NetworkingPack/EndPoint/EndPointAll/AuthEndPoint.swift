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
            return "\(baseAuthURL)Auths/register"
        case .login:
            return "\(baseAuthURL)Auths/login"
        case .confirmOTP:
            return "\(baseAuthURL)Auths/confirm-otp"
        case .resendOTP:
            return "\(baseAuthURL)Auths/resend-otp"
        case .forgetPassword:
            return "\(baseAuthURL)Auths/forget-password"
        case .resetPassword:
            return "\(baseAuthURL)Auths/reset-password"
        case .loginRefreshToken:
            return "\(baseAuthURL)Auths/login-refreshtoken"
        case .trustOTP:
            return "\(baseAuthURL)Auths/otp-trust"
        case .getMe:
            return "\(baseAuthURL)Users/getme"
        }
    }
}
