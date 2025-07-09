//
//  HomeVuewModel.swift
//  payapp
//
//  Created by Georgy on 2025-07-05.
//
import UIKit

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
    private let jsonService: JSONLoading
    
    init(view: SelectProfileHomeScreen,
         jsonService: JSONLoading = LocalJSONManager()) {
        self.view = view
        self.jsonService = jsonService
    }
    
    func loadProfiles() {
        Task { [weak view, jsonService] in
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
