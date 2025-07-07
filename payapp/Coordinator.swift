//
//  Coordinator.swift
//  payapp
//
//  Created by Georgy on 2025-07-06.
//
import UIKit

protocol Coordinator {
    func start()
    func openPaywallScreen(onCellSelected: @escaping SelectCellScreenHandler)
}
struct UIKitCoordinator: Coordinator {
    unowned var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        if let someScreen = window.rootViewController, let presentedViewController = someScreen.presentedViewController as? PaywallScreen {
            presentedViewController.dismiss(animated: true)
        } else {
            window.rootViewController = SelectProfileHomeScreen()
            window.makeKeyAndVisible()
        }
    }
    
    func openPaywallScreen(onCellSelected: @escaping SelectCellScreenHandler) {
        let payWallScreen = PaywallScreen()
        payWallScreen.onCellSelected = onCellSelected
        if let homeView = window.rootViewController as? AnyScreen{
            homeView.present(screen: payWallScreen)
        } else if window.rootViewController == nil {
            window.rootViewController = SelectProfileHomeScreen()
            window.makeKeyAndVisible()
            (window.rootViewController as? AnyScreen)?.present(screen: payWallScreen)
        }
    }
}
