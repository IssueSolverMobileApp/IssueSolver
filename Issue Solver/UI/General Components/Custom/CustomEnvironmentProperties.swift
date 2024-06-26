//
//  EnvironmentProperties.swift
//  Issue Solver
//
//  Created by Vusal Nuriyev 2 on 26.06.24.
//

import SwiftUI

struct RootPresentationKey: EnvironmentKey {
    static let defaultValue: Binding<Bool> = .constant(false)
}


extension EnvironmentValues {
    var isLoginRootPresenting: Binding<Bool> {
        get {
            self[RootPresentationKey.self]
        }
        set {
            self[RootPresentationKey.self] = newValue
        }
    }
}
