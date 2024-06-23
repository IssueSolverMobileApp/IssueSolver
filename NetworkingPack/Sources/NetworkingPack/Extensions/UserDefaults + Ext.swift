//
//  UserDefaults + Ext.swift
//
//
//  Created by Valeh Amirov on 22.06.24.
//

import Foundation


extension UserDefaults {
    
    enum Keys: String {
        case queryKey = "queryItemKey"
    }
    
    var queryToken: String? {
        get {
            return string(forKey: Keys.queryKey.rawValue)
        }
        set {
            setValue(newValue, forKey: Keys.queryKey.rawValue)
        }
    }
}
