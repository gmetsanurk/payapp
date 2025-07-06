//
//  LocalJSONManager.swift
//  payapp
//
//  Created by Georgy on 2025-07-05.
//
import Foundation

protocol JSONLoading {
    func loadProfiles() -> [ProfileModel]
}

struct LocalJSONManager: JSONLoading {
    
    private let resourceName: String
    
    init(resourceName: String = "Data") {
        self.resourceName = resourceName
    }
    
    func loadProfiles() -> [ProfileModel] {
        guard
            let url = Bundle.main.url(forResource: resourceName, withExtension: "json"),
            let data = try? Data(contentsOf: url)
        else { return [] }
        
        do {
            return try JSONDecoder().decode([ProfileModel].self, from: data)
        } catch {
            print("Error on JSON decoding", error)
            return []
        }
    }
}
