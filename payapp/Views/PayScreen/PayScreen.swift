//
//  PayScreen.swift
//  payapp
//
//  Created by Georgy on 2025-07-07.
//

import UIKit
import SnapKit
import Adapty
import AdaptyUI

typealias SelectCellScreenHandler = () -> Void

final class PayScreen: UIViewController {
    
    private lazy var viewModel = PayViewModel(view: self)
    
    private struct Slide {
        let title: NSAttributedString
        let image: UIImage?
    }
    
    private lazy var slides: [Slide] = []
    var slideControllers: [UIViewController] = []
    
    private var pageViewController: UIPageViewController!
    let pageControl = UIPageControl()
    private let bottomContainer = UIView()
    private let priceLabel = UILabel()
    private let detailLabel = UILabel()
    private var subscribeButton = UIButton(type: .system)
    private let termsStack = UIStackView()
    private let termsButton = UIButton(type: .system)
    private let privacyButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createSubscribeButton()
        createSlides()
        makeSlideControllers()
        setupPageViewController()
        setupPageControl()
        setupBottomArea()
        layoutAll()
        
        reloadProfileAdapty()
    }
    
}

extension PayScreen {
    
    private func reloadProfileAdapty() {
        Task {
            await viewModel.reloadProfile()
        }
    }
    
    func createSubscribeButton() {
        let button = UIButton(type: .system)
        button.setTitle("Subscribe", for: .normal)
        button.addAction(UIAction { [unowned self] _ in
            self.didTapSubscribe()
        }, for: .primaryActionTriggered)
        self.subscribeButton = button
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

extension PayScreen {
    
    func createSlides() {
        let slidesArray: [Slide] = [
            .init(
                title: setupSlideAttributes("Get ", highlight: "599 Coins", suffix: " NOW And Every Week"),
                image: UIImage(named: "payscreen-1")
            ),
            .init(
                title: setupSlideAttributes("Send ", highlight: "Unlimited Messages", suffix: ""),
                image: UIImage(named: "payscreen-2")
            ),
            .init(
                title: setupSlideAttributes("Turn Off ", highlight: "Camera & Sound", suffix: ""),
                image: UIImage(named: "payscreen-3")
            ),
            .init(
                title: setupSlideAttributes("Mark Your Profile With ", highlight: "VIP Status", suffix: ""),
                image: UIImage(named: "payscreen-4")
            )
        ]
        self.slides = slidesArray
    }
    
    func setupSlideAttributes(_ prefix: String, highlight: String, suffix: String) -> NSAttributedString {
        let full = NSMutableAttributedString(
            string: prefix,
            attributes: [
                .font: UIFont.systemFont(ofSize: 24, weight: .bold),
                .foregroundColor: UIColor.black
                ]
        )
        full.append(.init(
            string: highlight,
            attributes: [
                .font: UIFont.systemFont(ofSize: 24, weight: .bold),
                .foregroundColor: AppColors.pinkHighlightColor
            ]
        ))
        full.append(.init(
            string: suffix,
            attributes: [
                .font: UIFont.systemFont(ofSize: 24, weight: .bold),
                .foregroundColor: UIColor.black
                ]
        ))
        return full
    }
    
    private func makeSlideControllers() {
        slideControllers = slides.map { slide in
            let viewController = UIViewController()
            let imageView = UIImageView(image: slide.image)
            imageView.contentMode = .scaleAspectFit
            let label = UILabel()
            label.attributedText = slide.title
            label.numberOfLines = 0
            label.textAlignment = .center
            
            viewController.view.addSubview(label)
            viewController.view.addSubview(imageView)
            
            label.snp.makeConstraints { make in
                make.top.equalTo(viewController.view.safeAreaLayoutGuide).offset(24)
                make.leading.trailing.equalToSuperview().inset(32)
            }
            imageView.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.centerX.equalToSuperview()
                make.width.equalToSuperview().multipliedBy(0.9)
                make.height.equalTo(imageView.snp.width).multipliedBy(1.0)
            }
            return viewController
        }
    }
    
    func setupPageViewController() {
        pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: nil
        )
        
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.setViewControllers(
            [slideControllers[0]],
            direction: .forward,
            animated: false
        )
    }
    
    func setupPageControl() {
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.lightGray.withAlphaComponent(0.5)
        pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        view.addSubview(pageControl)
    }
    
    private func setupBottomArea() {
        view.addSubview(bottomContainer)
        view.addSubview(subscribeButton)
        
        bottomContainer.backgroundColor = AppColors.bottomContainerColor
        //bottomContainer.layer.cornerRadius = 30
        bottomContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        priceLabel.text = "Subscribe for $0.99 weekly"
        priceLabel.textColor = .white
        priceLabel.font = .systemFont(ofSize: 16, weight: .medium)
        priceLabel.textAlignment = .center
        
        detailLabel.text = "Plan automatically renews. Cancel anytime."
        detailLabel.textColor = .white
        detailLabel.font = .systemFont(ofSize: 12)
        detailLabel.textAlignment = .center
        
        subscribeButton.setTitle("Subscribe", for: .normal)
        subscribeButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        subscribeButton.backgroundColor = AppColors.subscribeButtonColor
        subscribeButton.layer.cornerRadius = 22
        subscribeButton.setTitleColor(.white, for: .normal)
        
        termsButton.setTitle("Terms of Use", for: .normal)
        termsButton.titleLabel?.font = .systemFont(ofSize: 12)
        termsButton.setTitleColor(.white, for: .normal)
        
        privacyButton.setTitle("Privacy & Policy", for: .normal)
        privacyButton.titleLabel?.font = .systemFont(ofSize: 12)
        privacyButton.setTitleColor(.white, for: .normal)
        
        termsStack.axis = .horizontal
        termsStack.distribution = .equalSpacing
        termsStack.addArrangedSubview(termsButton)
        termsStack.addArrangedSubview(privacyButton)
        
        bottomContainer.addSubview(priceLabel)
        bottomContainer.addSubview(detailLabel)
        bottomContainer.addSubview(subscribeButton)
        bottomContainer.addSubview(termsStack)
    }
    
    private func layoutAll() {
        pageViewController.view.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(bottomContainer.snp.top)
        }
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(pageViewController.view.snp.bottom).offset(-20)
            make.centerX.equalToSuperview()
        }
        bottomContainer.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(view.bounds.height * 0.35)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        subscribeButton.snp.makeConstraints { make in
            make.top.equalTo(detailLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(32)
            make.height.equalTo(44)
        }
        termsStack.snp.makeConstraints { make in
            make.top.equalTo(subscribeButton.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
    }
}

extension PayScreen: AnyScreen {
    func present(screen: UIViewController) {}
}
