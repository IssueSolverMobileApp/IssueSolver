//
//  RootView.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 11.07.24.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject var auth: AuthManager
    var body: some View {
        if auth.loggedIn {
            TabBarView()
        } else {
            LoginView()
        }
    }
}

