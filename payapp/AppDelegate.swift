//
//  AppDelegate.swift
//  payapp
//
//  Created by Georgy on 2025-07-04.
//

import UIKit
import Adapty



@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var coordinator: Coordinator?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        //Adapty.activate("public_live_XcszhjPr.4kS0P09Oj0L61jrl7Iu3")
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        let appCoordinator = UIKitCoordinator(window: window)
        self.coordinator = appCoordinator
        appCoordinator.start()

        return true
    }
    
}

