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
    
    var isValidPassword: Bool {
        func validatePassword(_ password: String) -> Bool {
            //At least 8 characters
            if password.count < 8 {
                return false
            }

            //At least one digit
            if password.range(of: #"\d+"#, options: .regularExpression) == nil {
                return false
            }

            //At least one letter
            if password.range(of: #"\p{Alphabetic}+"#, options: .regularExpression) == nil {
                return false
            }

            //No whitespace charcters
            if password.range(of: #"\s+"#, options: .regularExpression) != nil {
                return false
            }

            return true
        }
        return true
    }
}
