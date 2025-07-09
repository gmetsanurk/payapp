//
//  HomeVuewModel.swift
//  payapp
//
//  Created by Georgy on 2025-07-05.
//

import UIKit
import Swinject

protocol AnyScreen {
    func present(screen: UIViewController)
}

extension AnyScreen where Self: UIViewController {
    @MainActor
    func present(screen: UIViewController) {
        present(screen, animated: true)
    }
}

class HomeViewModel {
    private weak var view: SelectProfileHomeScreen?
    
    init(view: SelectProfileHomeScreen) {
        self.view = view
    }
    
    func loadProfiles() {
        Task { [weak view] in
            guard let jsonService = dependencies.container.resolve(JSONLoading.self) else {
                return
            }
            let models = await jsonService.loadProfiles()
        
            let profiles = models.map {
                ProfileModel (
                    name: $0.name,
                    age: $0.age,
                    flag: $0.flag,
                    imageName: $0.imageName ?? "",
                    statusText: $0.statusText ?? "offline"
                )
            }
            await view?.displayProfiles(profiles)
        }
    }
    
    func handleSelect() {
        Task {
            let coordinator = await dependencies.container.resolve(Coordinator.self)
            await coordinator?.openPaywallScreen() 
        }
    }
}
