//
//  HomePresenter.swift
//  payapp
//
//  Created by Georgy on 2025-07-05.
//

class HomePresenter {
    private weak var view: SelectProfileHomeScreen?
    private let jsonService: JSONLoading
    
    init(view: SelectProfileHomeScreen,
         jsonService: JSONLoading = LocalJSONManager()) {
        self.view = view
        self.jsonService = jsonService
    }
    
    
    
}
