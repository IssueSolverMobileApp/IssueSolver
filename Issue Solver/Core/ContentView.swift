//
//  ContentView.swift
//  Issue Solver
//
//  Created by Vusal Nuriyev on 24.06.24.
//

import SwiftUI

struct ContentView: View {
    
    @State var showView: Bool = false
    
    var body: some View {
        ZStack {
            if !showView {
                SplashScreen {
                    withAnimation(.easeInOut) {
                        showView = true
                    }
                }
            } else {
                RootView()
                    .environmentObject(AuthManager.shared)
            }
        }
    }
}

#Preview {
    ContentView()
}
