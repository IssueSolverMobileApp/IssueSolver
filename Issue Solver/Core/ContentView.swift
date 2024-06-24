//
//  ContentView.swift
//  Issue Solver
//
//  Created by Vusal Nuriyev on 24.06.24.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab: Tab = .home
    
    var body: some View {
        NavigationView {
            RegisterView()
        }
    }
}

#Preview {
    ContentView()
}
