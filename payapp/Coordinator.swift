//
//  Coordinator.swift
//  payapp
//
//  Created by Georgy on 2025-07-06.
//
import UIKit

protocol Coordinator {
    func start()
}
struct UIKitCoordinator: Coordinator {
    unowned var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        window.rootViewController = SelectProfileHomeScreen()
        window.makeKeyAndVisible()
    }
}
