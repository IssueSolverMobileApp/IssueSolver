//
//  ContentView.swift
//  Issue Solver
//
//  Created by Vusal Nuriyev on 24.06.24.
//

import SwiftUI

struct ContentView: View {
        
    var body: some View {
        ZStack {
//            CustomNavigationStack {
              RootView()
                    .environmentObject(AuthManager.shared)
//            }
//            .ignoresSafeArea()
        }
    }
}

#Preview {
    ContentView()
}
