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
        // get paywall object with Placement ID
        let paywall = try await Adapty.getPaywall(
            placementId: AppConstants.placementId
        )
        // configure paywall
        let configuration = try await AdaptyUI.getPaywallConfiguration(
            forPaywall: paywall
        )
        // create controller of completed paywall screen
        let paywallController = try? AdaptyUI.paywallController(
            with: configuration,
            delegate: self
        )
        // show
        guard let paywallController = paywallController else { return }
        present(paywallController, animated: true)
    }
    
    // when customer finish purchasing
    func paywallDidFinishPurchase(
        _ controller: AdaptyPaywallController,
        product: AdaptyPaywallProduct,
        profile: AdaptyProfile
    ) {
        controller.dismiss(animated: true)
        // TODO: reload UI
    }
    
    // customer pressed close button
    func paywallDidClose(_ controller: AdaptyPaywallController) {
        controller.dismiss(animated: true)
    }
    
    // MARK: AdaptyPaywallControllerDelegate
    
    // Customer's purchase failed
    func paywallController(
        _ controller: AdaptyPaywallController,
        didFailPurchase product: AdaptyPaywallProduct,
        error: AdaptyError
    ) {
        controller.dismiss(animated: true)
        showAlert(title: "Purchase fail", message: error.localizedDescription)
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
