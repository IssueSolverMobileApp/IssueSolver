//
//  EndPoint.swift
//  
//
//  Created by Valeh Amirov on 22.06.24.
//

import Foundation

public enum EndPoint: EndPointProtocol {
    
    case auth(AuthEndPoint)
    
    var url: String {
        switch self {
        case .auth(let authEndPoint):
            return authEndPoint.url
        }
    }
}

public enum AuthEndPoint: EndPointProtocol {
    
    case register
    case login
    case confirmOTP
    case resendOTP
    case forgetPassword
    case resetPassword
    case loginRefreshToken
    case trustOTP
    
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
        }
    }
}

protocol EndPointProtocol {
    var baseURL: String { get }
    var url: String { get }
}

extension EndPointProtocol {
    
    var baseURL: String {
        return "https://govermentauthapi20240610022027.azurewebsites.net/api/"
    }

}
