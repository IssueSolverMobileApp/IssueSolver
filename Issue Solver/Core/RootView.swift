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
        
        ZStack {
            Color.surfaceBackground.ignoresSafeArea()
            
            if auth.loggedIn {
                CustomNavigationStack {
                    TabBarView()
                }
                .ignoresSafeArea(edges: .bottom)
            } else {
                CustomNavigationStack {
                    LoginView()
                }
                .ignoresSafeArea(edges: .bottom)
            }
        }
    }
}

