//
//  PayViewModel.swift
//  payapp
//
//  Created by Georgy on 2025-07-07.
//

import Adapty
import Combine
import Foundation

final class PayViewModel: NSObject, ObservableObject, AdaptyDelegate {
    
    private weak var view: PayScreen?
    
    @Published var profile: AdaptyProfile?
    @Published var isLoading = false
    
    init(view: PayScreen) {
        self.view = view
        super.init()
        
        Adapty.delegate = self
        Task {
            await reloadProfile()
        }
    }
    
    @MainActor
    func reloadProfile() async {
        do {
            isLoading = true
            profile = try await Adapty.getProfile()
        } catch {
            Logger.log(.error, "reloadProfile: \(error)")
        }
        
        isLoading = false
    }
    
    
    // MARK: AdaptyDelegate
    func didLoadLatestProfile(_ profile: AdaptyProfile) {
        Task {
            await MainActor.run {
                self.profile = profile
            }
        }
    }
}

extension PayViewModel: @unchecked Sendable {
}
