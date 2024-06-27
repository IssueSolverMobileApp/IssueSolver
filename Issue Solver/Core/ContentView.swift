//
//  ContentView.swift
//  Issue Solver
//
//  Created by Vusal Nuriyev on 24.06.24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var coordinator: NavigationCoordinator
    
    @State var selectedTab: Tab = .home
    @State private var isRootPresenting: Bool = false
    var body: some View {
        NavigationView {
            LoginView()
                .environmentObject(coordinator)
        }
    }
}

#Preview {
    ContentView()
}
