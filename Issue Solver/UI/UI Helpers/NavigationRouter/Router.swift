//
//  Router.swift
//  Issue Solver
//
//  Created by Vusal Nuriyev 2 on 29.06.24.
//

import SwiftUI

/*
 - Class 'Router' creates a navigation stack from the view you pass to setupNavigationController, which can push view controllers and pop to the root view.
 - This is a basic class, which can be used for all views and manipulate them
*/

final class Router: NSObject, ObservableObject, UINavigationControllerDelegate {
    
    var navigationController: UINavigationController = UINavigationController()
    
    override init() {
        super.init()
        setupNavigation()
    }
    
    /// - Parameters:
    ///  - setupNavigationController: Create a new navigation controller, which will be the root of a navigaiton stack
    
    /// Every time we create a new hosting controller, which is a view controller of a SwiftUI view,
    /// we have to pass observed object of a `Router` class to each view, to be able to use router functions
    /// to manipulate view controllers of a navigation stack further.
    /// * Use `self` to pass as an environment object to another view
    
    public func setupNavigationController<C: View>(with view: C) -> UINavigationController {
        let rootViewController = UIHostingController(rootView: view.environmentObject(self))
        navigationController.viewControllers.append(rootViewController)
        return navigationController
    }
    
    // MARK: - Custom Setup
    
    private func setupNavigation() {
        navigationController.delegate = self
    
        /// - Customization navigation bar appearance
        let navigationBar = navigationController.navigationBar
        navigationBar.isTranslucent = true
    }
    
    // MARK: - Navigation Controller Functions
    
    /// - Parameters:
    ///  - navigate: Pushes a new view controller onto the existing navigation stack
    ///  - popToRoot: Pops to the root view controller, which is in the existing navigation stack
    ///  - dismissView: Dismisses the view controller, which is visible right now
    
    public func navigate<C: View>(@ViewBuilder view: () -> C) {
        let newHostingController = UIHostingController(rootView: view().environmentObject(self))
        navigationController.pushViewController(newHostingController, animated: true)
    }
    
    public func popToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
    
    public func dismissView() {
        navigationController.popViewController(animated: true)
    }
    
    // MARK: - UINavigationControllerDelegate
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        /// - Customize navigation item and navigation bar of the view controller, which will be shown
        viewController.navigationItem.hidesBackButton = true
        viewController.navigationController?.navigationBar.isTranslucent = true
    }
}

