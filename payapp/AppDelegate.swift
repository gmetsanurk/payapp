//
//  AppDelegate.swift
//  payapp
//
//  Created by Georgy on 2025-07-04.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        setupWindow()
        return true
    }
    
    private func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let homeVC = SelectProfileHomeScreen()
        window?.rootViewController = homeVC
        window?.makeKeyAndVisible()
    }
}

