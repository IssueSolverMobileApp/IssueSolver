//
//  EnvironmentProperties.swift
//  Issue Solver
//
//  Created by Vusal Nuriyev 2 on 26.06.24.
//

import SwiftUI

//struct RootPresentationKey: EnvironmentKey {
//    static let defaultValue: Binding<Bool> = .constant(false)
//}
//
//
//extension EnvironmentValues {
//    var isLoginRootPresenting: Binding<Bool> {
//        get {
//            self[RootPresentationKey.self]
//        }
//        set {
//            self[RootPresentationKey.self] = newValue
//        }
//    }
//}

struct RootPresentationModeKey: EnvironmentKey {
    static let defaultValue: Binding<RootPresentationMode> = .constant(RootPresentationMode())
}

extension EnvironmentValues {
    var rootPresentationMode: Binding<RootPresentationMode> {
        get { return self[RootPresentationModeKey.self] }
        set { self[RootPresentationModeKey.self] = newValue }
    }
}

typealias RootPresentationMode = Bool

extension RootPresentationMode {
    
    public mutating func dismiss() {
        self.toggle()
    }
}
