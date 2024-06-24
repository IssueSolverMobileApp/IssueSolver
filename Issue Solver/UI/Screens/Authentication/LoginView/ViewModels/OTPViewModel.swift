//
//  OTPViewModel.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 21.06.24.
//

import Foundation

final class OTPViewModel: ObservableObject {
    
    @Published var text: String = ""
    
    private var authRepository = HTTPAuthRepository()
    
}
