//
//  Auth.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 10.07.24.
//

import Foundation
import NetworkingPack

final class AuthManager {
    
    static let shared = AuthManager()
    
    private init () {
        loggedIn = hasAccessToken()
    }
    
    @Published var loggedIn: Bool = false
    
    
    func getCredential() -> String? {
        return UserDefaults.standard.accessToken
    }
    
    func hasAccessToken() -> Bool {
        return getCredential() != nil
    }
    
    func logOut() {
        UserDefaults.standard.accessToken = nil
        UserDefaults.standard.refreshToken = nil
    }
}
