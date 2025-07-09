//
//  Coordinator.swift
//  payapp
//
//  Created by Georgy on 2025-07-06.
//

import UIKit

protocol Coordinator: Actor {
    @MainActor
    func start() async
    @MainActor
    func openPaywallScreen() async
    func openOnline()
    func openPopular()
}

extension Coordinator {
    func openOnline() { }
    func openPopular() { }
}

final actor UIKitCoordinator: Coordinator {
    unowned var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    @MainActor
    func start() async {
        if let someScreen = await window.rootViewController, let presentedViewController = someScreen.presentedViewController as? PayScreen {
                presentedViewController.dismiss(animated: true)
            } else {
                await window.rootViewController = MainTabBarController()
                await window.makeKeyAndVisible()
            }
    }
    
    @MainActor
    func openPaywallScreen() async {
        let payWallScreen = PayScreen()
        if let tab = await window.rootViewController as? UITabBarController,
           let current = tab.selectedViewController as? AnyScreen {
            current.present(screen: payWallScreen)
        } else if await window.rootViewController == nil {
            await window.rootViewController = SelectProfileHomeScreen()
            await window.makeKeyAndVisible()
            await (window.rootViewController as? AnyScreen)?.present(screen: payWallScreen)
        }
    }
}
