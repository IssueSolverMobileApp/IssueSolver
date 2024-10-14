//
//  Auth.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 10.07.24.
//

import Foundation
import NetworkingPack

final class AuthManager: ObservableObject {
    
    static let shared = AuthManager()
    
    let http: HTTPClient = .shared

    private init () {
        loggedIn = hasAccessToken()
        http.deletage = self
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
        loggedIn = false
    }
}


extension AuthManager: AuthTriggerProtocol {
    func accessTokenTrigger(isActive: Bool) {
        DispatchQueue.main.async {
            self.loggedIn = isActive
        }
    }
}
