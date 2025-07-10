//
//  PayScreenAdaptyProtocol.swift
//  payapp
//
//  Created by Georgy on 2025-07-09.
//

import UIKit
import Adapty
import AdaptyUI

extension PayScreen: AdaptyPaywallControllerDelegate {
    
    func fetchAdaptyPaywall() async throws {
        let paywall = try await Adapty.getPaywall(
            placementId: AppConstants.placementId
        )
        let configuration = try await AdaptyUI.getPaywallConfiguration(
            forPaywall: paywall
        )
        let paywallController = try? AdaptyUI.paywallController(
            with: configuration,
            delegate: self
        )
        guard let paywallController = paywallController else { return }
        present(paywallController, animated: true)
    }
    
    func paywallDidFinishPurchase(
        _ controller: AdaptyPaywallController,
        product: AdaptyPaywallProduct,
        profile: AdaptyProfile
    ) {
        controller.dismiss(animated: true)
    }

    func paywallDidClose(_ controller: AdaptyPaywallController) {
        controller.dismiss(animated: true)
    }
    
    // MARK: AdaptyPaywallControllerDelegate
    
    func paywallController(
        _ controller: AdaptyPaywallController,
        didFailPurchase product: AdaptyPaywallProduct,
        error: AdaptyError
    ) {
        controller.dismiss(animated: true)
        showAlert(title: "purchase.error.title".localized, message: error.localizedDescription)
    }
    
    func paywallController(
        _ controller: AdaptyPaywallController,
        didFinishRestoreWith profile: AdaptyProfile
    ) {
        // handle the restore result
    }
    
    func paywallController(
        _ controller: AdaptyPaywallController,
        didFailRestoreWith error: AdaptyError
    ) {
        // handle the error
    }
}
