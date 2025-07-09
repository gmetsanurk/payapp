//
//  PayWallScreen.swift
//  payapp
//
//  Created by Georgy on 2025-07-07.
//

import UIKit
import Adapty
import AdaptyUI
import SnapKit
import Combine
import SwiftUICore

typealias SelectCellScreenHandler = () -> Void

class PayScreen: UIViewController {
    
    private let viewModel = PayViewModel.shared
    
    private var subscribeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createButton()
        setupUI()
        
        Task {
            await viewModel.reloadProfile()
        }
    }
    
}

extension PayScreen {
    
    func createButton() {
        subscribeButton = UIButton(type: .system)
        subscribeButton.setTitle("Subscribe", for: .normal)
        subscribeButton.addAction(UIAction { [unowned self] _ in
            self.didTapSubscribe()
        }, for: .primaryActionTriggered)
    }
    
    private func didTapSubscribe() {
        Task {
            do {
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
                
            } catch {
                // show alert in the case of an error
                showAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
    
    private func showAlert(title: String, message: String) {
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      alert.addAction(.init(title: "OK", style: .default))
      present(alert, animated: true)
    }
    
    private func setupUI() {
        view.addSubview(subscribeButton)
        
        subscribeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}

extension PayScreen: AdaptyPaywallControllerDelegate {
    
    // when customer finish purchasing
    func paywallDidFinishPurchase(
        _ controller: AdaptyPaywallController,
        product: AdaptyPaywallProduct,
        profile: AdaptyProfile
    ) {
        controller.dismiss(animated: true)
        // TODO: reload UI
    }

    // purchase failing
    func paywallDidFailPurchase(
        _ controller: AdaptyPaywallController,
        product: AdaptyPaywallProduct,
        error: Error
    ) {
        controller.dismiss(animated: true)
        showAlert(title: "Purchase fail", message: error.localizedDescription)
    }

    // customer pressed closew button
    func paywallDidClose(_ controller: AdaptyPaywallController) {
        controller.dismiss(animated: true)
    }
    
    // MARK: AdaptyPaywallControllerDelegate

    func paywallController(
        _ controller: AdaptyPaywallController,
        didFailPurchase product: AdaptyPaywallProduct,
        error: AdaptyError
    ) {
        // handle the error
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

extension PayScreen: AnyScreen {
    func present(screen: UIViewController) {}
}
