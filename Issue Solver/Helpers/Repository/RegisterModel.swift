//
//  RegisterModel.swift
//  Issue Solver
//
//  Created by ValehAmirov on 13.06.24.
//

import Foundation

struct RegisterModel: Codable {
    let email, firstName, lastName, password: String?
    let confirmPassword: String?
}


struct EncodeRegister {
    let email: String? = ""
    let firstName: String? = ""
let lastName: String? = ""
let password: String? = ""
    let confirmPassword: String? = ""
}
