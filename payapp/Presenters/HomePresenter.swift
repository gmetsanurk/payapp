//
//  HomePresenter.swift
//  payapp
//
//  Created by Georgy on 2025-07-05.
//

class HomePresenter {
    var profiles: [ProfileModel] = []
    private let jsonManager: JSONLoading = LocalJSONManager()
    
    func handleLoadProfiles() {
        profiles = jsonManager.loadProfiles()
    }
}
