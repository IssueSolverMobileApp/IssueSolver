//
//  Issue_SolverApp.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 11.06.24.
//

import SwiftUI

@main
struct Issue_SolverApp: App {
    @State var selectedTab: Tab = .home
    var body: some Scene {
        WindowGroup {
            GeometryReader { proxy in
                ZStack {
                    
                    Color.black.ignoresSafeArea()
                    VStack {
                        Spacer()
                        TabBarView(widthOfView: proxy.size.width, selectedTab: $selectedTab)
                    }
                }
            }
        }
    }
}
