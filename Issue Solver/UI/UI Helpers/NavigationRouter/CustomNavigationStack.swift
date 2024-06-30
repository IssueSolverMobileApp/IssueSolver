//
//  NavigationStack.swift
//  Issue Solver
//
//  Created by Vusal Nuriyev 2 on 29.06.24.
//

import SwiftUI

struct CustomNavigationStack<C: View>: UIViewControllerRepresentable {
    
    @ObservedObject var router: Router = Router()
    @ViewBuilder var rootView: () -> C
    
    init(@ViewBuilder root: @escaping () -> C) {
        self.rootView = root
    }
    
    func makeUIViewController(context: Context) -> UINavigationController {
        return self.router.setupNavigationController(with: rootView())
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        // Do not update
    }
    
}
