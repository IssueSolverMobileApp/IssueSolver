//
//  Navigato.swift
//  Issue Solver
//
//  Created by Vusal Nuriyev on 27.06.24.
//

import SwiftUI

// Use ObservableObject to inject NavigationCoordinator into
// SwiftUI views as EnvironmentObject
class NavigationCoordinator: ObservableObject {
    // Reference to a UINavigationController
    private lazy var navigationController: UINavigationController = .init()
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    // Start function
    func start<Content: View>(content: Content) {
        let viewWithCoordinator = content.environmentObject(self)
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        navigationController.setViewControllers([viewController], animated: false)
    }
    // Pushing Views into navigation stack
    func show<Destination: View>(_ view: Destination, animated: Bool = true) {
        let viewWithCoordinator = view.environmentObject(self)
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func pop(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }

    func popToRoot(animated: Bool = true) {
        navigationController.popToRootViewController(animated: animated)
    }
}
