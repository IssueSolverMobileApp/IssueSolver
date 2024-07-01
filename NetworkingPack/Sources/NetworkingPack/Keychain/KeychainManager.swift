//
//  KeychainManager.swift
//
//
//  Created by Valeh Amirov on 27.06.24.
//

import Foundation

enum TokenEnum: String {
    case accessToken
    case refreshToken
    
    var value: String {
        switch self {
        case .accessToken:
            return "Authorization"
        case .refreshToken:
            return "refreshToken"
        }
    }
}

enum KeychainError: Error {
    case duplicateItem
    case unknown (status: OSStatus)
    case nilItem
}

final public class KeychainManager {
    
    
    public func save(token: String, key: String) {
        do {
            try KeychainManager.saveData(password: token.data(using: .utf8) ?? Data(), account: key)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func get(for Key: String) -> String {
        
        do {
            guard let data = try KeychainManager.getData(for: Key) else { throw KeychainError.nilItem }
            let string = String(decoding: data, as: UTF8.self)
            return string
        }
        catch {
            print(error.localizedDescription)
        }
        return String()
    }
    
    static private func saveData(password: Data, account: String) throws  {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecValueData: password,
        ]
    
        let status = SecItemAdd(query as CFDictionary, nil)
        
        
        guard status != errSecDuplicateItem else { throw KeychainError.duplicateItem }
        
        
        guard status == errSecSuccess else { throw KeychainError.unknown(status: status) }
    }
    
    static private func getData(for account: String) throws -> Data? {
        
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecReturnData: kCFBooleanTrue as Any
        ]
        
        var result: AnyObject?
        
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess else { throw KeychainError.unknown(status: status)}
        
        return result as? Data
    }
}
