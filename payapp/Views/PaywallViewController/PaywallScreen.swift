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

typealias SelectCellScreenHandler = () -> Void

class PaywallScreen: UIViewController {
    
    private let viewModel = PaywallViewModel.shared
    
    private var subscribeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createButton()
        setupUI()
        
        Task {
            await viewModel.reloadProfile()
            await viewModel.loadPaywall()
        }
    }
    
}

extension PaywallScreen {
    
    func createButton() {
        subscribeButton = UIButton(type: .system)
        subscribeButton.setTitle("Subscribe", for: .normal)
        subscribeButton.addAction(UIAction { [unowned self] _ in
            self.didTapSubscribe()
        }, for: .primaryActionTriggered)
    }
    
    private func didTapSubscribe() {
        Task {
            if viewModel.isPremiumUser {
                showAlert(title: "Subscribed", message: "Your subscription is already active.")
                                return
            }
            
            guard let result = await viewModel.purchase() else {
                showAlert(title: "Error", message: "Unable to start purchase.")
                                return
            }
            
            if result.isPurchaseCancelled {
                showAlert(title: "Cancelled", message: "You cancelled the purchase.")
            } else if result.isPurchasePending {
                showAlert(title: "Pending", message: "Your purchase is pending approval.")
            } else if let updatedProfile = result.profile {
                showAlert(title: "Success", message: "Your subscription is now active!")
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

extension PaywallScreen: AnyScreen {
    func present(screen: UIViewController) {}
}
