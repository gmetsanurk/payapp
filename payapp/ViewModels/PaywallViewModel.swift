//
//  PaywallViewModel.swift
//  payapp
//
//  Created by Georgy on 2025-07-07.
//

import Adapty
import Combine
import Foundation

final class PayViewModel: NSObject, ObservableObject, AdaptyDelegate {
    
    static let shared = PayViewModel()
    
    var isPremiumUser: Bool { profile?.accessLevels[AppConstants.accessLevelId]?.isActive ?? false }
    
    private let placementId = AppConstants.placementId
    
    @Published var profile: AdaptyProfile?
    
    @Published var isLoading = false
    @Published var premiumProduct: AdaptyPaywallProduct?
    
    override init() {
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
