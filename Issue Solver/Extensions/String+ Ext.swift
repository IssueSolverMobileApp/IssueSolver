//
//  String+ Ext.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 24.06.24.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        let regularExpression = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
         let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)

         return passwordValidation.evaluate(with: self)
    }
}
        