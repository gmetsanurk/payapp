//
//  PayWallScreen.swift
//  payapp
//
//  Created by Georgy on 2025-07-07.
//
import UIKit
import Adapty
import AdaptyUI

typealias SelectCellScreenHandler = () -> Void

class PaywallScreen: UIViewController {
    
    private let viewModel = PaywallViewModel.shared
    private var paywall: AdaptyPaywall!
    private var premiumProduct: AdaptyPaywallProduct?
    private unowned var subscribeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
}

extension PaywallScreen {
    
    func createButton() {
        subscribeButton.setTitle("Subscribe", for: .normal)
        subscribeButton.addAction(UIAction { [unowned self] _ in
            self.didTapSubscribe()
        }, for: .primaryActionTriggered)
    }
    
    private func didTapSubscribe() {
        Task {
            if viewModel.isPremiumUser {
                showAlert(title: "Already Subscribed",
                          message: "You already have an active subscription.")
                return
            }
            
            guard let product = premiumProduct else {
                showAlert(title: "Error", message: "Premium product not loaded")
                return
            }
            try await viewModel.purchase(product: product)
        }
    }
    
    private func showAlert(title: String, message: String) {
      let a = UIAlertController(title: title, message: message, preferredStyle: .alert)
      a.addAction(.init(title: "OK", style: .default))
      present(a, animated: true)
    }
}

extension PaywallScreen: AnyScreen {
    func present(screen: UIViewController) {}
}
