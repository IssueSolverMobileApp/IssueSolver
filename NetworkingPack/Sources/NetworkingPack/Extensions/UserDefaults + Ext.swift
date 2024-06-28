//
//  UserDefaults + Ext.swift
//
//
//  Created by Valeh Amirov on 22.06.24.
//

import Foundation


public extension UserDefaults {
    
    enum Keys: String {
        case queryKey = "queryItemKey"
        case accessTokenKey = "accessToken"
        case refreshTokenKey = "refreshToken"
    }
    
    var queryToken: String? {
        get {
            return string(forKey: Keys.queryKey.rawValue)
        }
        set {
            setValue(newValue, forKey: Keys.queryKey.rawValue)
        }
    }
    
    var accessToken: String? {
        get {
            return string(forKey: Keys.accessTokenKey.rawValue)
        }
        set {
            setValue(newValue, forKey: Keys.accessTokenKey.rawValue)
        }
    }

    var refreshToken: String? {
        get {
            return string(forKey: Keys.refreshTokenKey.rawValue)
        }
        set {
            setValue(newValue, forKey: Keys.refreshTokenKey.rawValue)
        }
    }
}
