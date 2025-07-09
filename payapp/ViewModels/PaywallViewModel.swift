//
//  PaywallViewModel.swift
//  payapp
//
//  Created by Georgy on 2025-07-07.
//

import Adapty
import Combine
import Foundation

final class PaywallViewModel: NSObject, ObservableObject, AdaptyDelegate {
    
    static let shared = PaywallViewModel()
    
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
    
    func loadPaywall() async {
        do {
            isLoading = true
            let pw = try await Adapty.getPaywall(placementId: placementId)
            let items = try await Adapty.getPaywallProducts(paywall: pw)
            premiumProduct = items.first
            print("Loaded premiumProduct:", premiumProduct?.vendorProductId ?? "none")
        } catch {
            print("loadPaywall failed:", error)
        }
        isLoading = false
    }
    
    @MainActor
    func purchase() async -> AdaptyPurchaseResult? {
        guard let product = premiumProduct else { return nil }
        do {
            let result = try await Adapty.makePurchase(product: product)
            return result
        } catch {
            print("Make purchase failed", error)
            return nil
        }
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

extension PaywallViewModel: @unchecked Sendable {
}
