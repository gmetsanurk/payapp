//
//  AppDelegate.swift
//  payapp
//
//  Created by Georgy on 2025-07-04.
//

import UIKit
import Adapty
import AdaptyUI
import Swinject


actor Dependencies {
    let container = {
        let container = Container()
        container.register(JSONLoading.self) { _ in
            LocalJSONManager()
        }
        return container
    }()
}

extension Container: @retroactive @unchecked Sendable { }
let dependencies = Dependencies()

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var coordinator: Coordinator?
    
    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        let configuration = AdaptyConfiguration
            .builder(withAPIKey: AppConstants.adaptyApiKey)
            .with(customerUserId: UserManager.currentUserId)
            .build()

        Adapty.logLevel = .verbose
        Adapty.activate(with: configuration)

        if #available(iOS 15.0, *) {
            AdaptyUI.activate()
        }
        
        setupWindow()
        return true
    }
    
    func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        dependencies.container.register(Coordinator.self) { [weak self] _ in
            UIKitCoordinator(window: self?.window ?? .init())
        }
        Task {
            await dependencies.container.resolve(Coordinator.self)?.start()
        }
    }
}

