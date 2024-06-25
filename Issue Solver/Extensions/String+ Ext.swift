//
//  String+ Ext.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 25.06.24.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    
    var isValidCharacterCount: Bool {
        return count >= 8
    }
    
    var isValidPassword: Bool {
        // At least one digit
        let digitRegex = ".*\\d.*"
        guard NSPredicate(format: "SELF MATCHES %@", digitRegex).evaluate(with: self) else {
            return false
        }
        
        // At least one lowercase letter
        let lowercaseLetterRegex = ".*[a-z].*"
        guard NSPredicate(format: "SELF MATCHES %@", lowercaseLetterRegex).evaluate(with: self) else {
            return false
        }
        
        // At least one uppercase letter
        let uppercaseLetterRegex = ".*[A-Z].*"
        guard NSPredicate(format: "SELF MATCHES %@", uppercaseLetterRegex).evaluate(with: self) else {
            return false
        }
        
        // At least one special character
        let specialCharacterRegex = ".*[!@#$%^&*(),.?\":{}|<>].*"
        guard NSPredicate(format: "SELF MATCHES %@", specialCharacterRegex).evaluate(with: self) else {
            return false
        }
        
        // No whitespace characters
        let whitespaceRegex = ".*\\s.*"
        guard !NSPredicate(format: "SELF MATCHES %@", whitespaceRegex).evaluate(with: self) else {
            return false
        }
        
        return true
    }
}
