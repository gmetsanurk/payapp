//
//  HomePresenter.swift
//  payapp
//
//  Created by Georgy on 2025-07-05.
//
import UIKit

protocol AnyScreen {
    func present(screen: AnyScreen)
}

extension AnyScreen where Self: UIViewController {
    func presentController(screen: AnyScreen & UIViewController) {
        present(screen, animated: true)
    }
}

class HomePresenter {
    private weak var view: SelectProfileHomeScreen?
    private let jsonService: JSONLoading
    
    init(view: SelectProfileHomeScreen,
         jsonService: JSONLoading = LocalJSONManager()) {
        self.view = view
        self.jsonService = jsonService
    }
    
    func loadProfiles() {
        let models = jsonService.loadProfiles()
        
        let profiles = models.map {
            ProfileModel (
                name: $0.name,
                age: $0.age,
                flag: $0.flag,
                imageName: $0.imageName ?? "",
                statusText: $0.statusText ?? "offline"
            )
        }
        view?.displayProfiles(profiles)
    }
}
