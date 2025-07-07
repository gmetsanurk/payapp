//
//  AppDelegate.swift
//  payapp
//
//  Created by Georgy on 2025-07-04.
//

import UIKit
import Adapty
import Swinject

struct Dependencies {
    let container = {
        let container = Container()
        return container
    }()
    
    func resolve<Service>(_ serviceType: Service.Type) -> Service? {
        container.resolve(serviceType)
    }
}

let dependencies = Dependencies()

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var coordinator: Coordinator?
    
    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        //Adapty.activate("public_live_XcszhjPr.4kS0P09Oj0L61jrl7Iu3")
        setupWindow()
        return true
    }
    
    func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        dependencies.container.register(Coordinator.self) { [weak self] _ in
            UIKitCoordinator(window: self?.window ?? .init())
        }
        dependencies.resolve(Coordinator.self)?.start()
    }
}

