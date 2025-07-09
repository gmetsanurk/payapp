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

class PaywallScreen: UIViewController {
    
    private let viewModel = PaywallViewModel.shared
    
    @State private var isPresentingProfile: Bool = false
    @State private var isPresentingPaywall: Bool = false
    
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
            do {
                // 3.1. Получаем объект paywall по вашему Placement ID
                let paywall = try await Adapty.getPaywall(
                    placementId: AppConstants.placementId
                )
                
                // 3.2. Конфигурируем UI-детали вашего paywall
                let configuration = try await AdaptyUI.getPaywallConfiguration(
                    forPaywall: paywall
                )
                
                // 3.3. Создаём контроллер готового paywall-экрана
                let paywallController = try? AdaptyUI.paywallController(
                    with: configuration,
                    delegate: self   // 4. Слушаем события paywall
                )
                
                // 3.4. Показываем его модально
                guard let paywallController = paywallController else { return }
                present(paywallController, animated: true)
                
            } catch {
                // В случае ошибки — показываем alert
                showAlert(title: "Ошибка", message: error.localizedDescription)
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

extension PaywallScreen: AdaptyPaywallControllerDelegate {
    
    // Когда пользователь покупает продукт
    func paywallDidFinishPurchase(
        _ controller: AdaptyPaywallController,
        product: AdaptyPaywallProduct,
        profile: AdaptyProfile
    ) {
        controller.dismiss(animated: true)
        // TODO: обновить UI или viewModel по новому профилю
    }

    // Ошибка покупки
    func paywallDidFailPurchase(
        _ controller: AdaptyPaywallController,
        product: AdaptyPaywallProduct,
        error: Error
    ) {
        controller.dismiss(animated: true)
        showAlert(title: "Ошибка покупки", message: error.localizedDescription)
    }

    // Пользователь нажал закрыть
    func paywallDidClose(_ controller: AdaptyPaywallController) {
        controller.dismiss(animated: true)
    }

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

extension PaywallScreen: AnyScreen {
    func present(screen: UIViewController) {}
}
