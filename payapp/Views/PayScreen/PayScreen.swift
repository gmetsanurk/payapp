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
    
    private lazy var slides: [Slide] = []
    var slideControllers: [UIViewController] = []
    
    private var pageViewController: UIPageViewController!
    let pageControl = UIPageControl()
    private let bottomContainer = UIView()
    private let priceLabel = UILabel()
    private let detailLabel = UILabel()
    private let termsStack = UIStackView()
    private var subscribeButton = UIButton(type: .system)
    private let closeButton = UIButton(type: .system)
    private let restoreButton = UIButton(type: .system)
    private let termsButton = UIButton(type: .system)
    private let privacyButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createSubscribeButton()
        createSlides()
        makeSlideControllers()
        setupTopCloseButton()
        setupTopRestoreButton()
        setupPageViewController()
        setupPageControl()
        setupBottomArea()
        layoutAll()
        
        reloadProfileAdapty()
    }
    
}

extension PayScreen {
    
    func reloadProfileAdapty() {
        Task {
            await viewModel.reloadProfile()
        }
    }
    
    private func createSubscribeButton() {
        let button = UIButton(type: .system)
        button.setTitle("subscribe.button".localized, for: .normal)
        button.addAction(UIAction { [unowned self] _ in
            self.didTapSubscribe()
        }, for: .primaryActionTriggered)
        self.subscribeButton = button
    }
    
    private func didTapSubscribe() {
        Task {
            do {
                try await fetchAdaptyPaywall()
            } catch {
                showAlert(title: "alert.error.title".localized, message: error.localizedDescription)
            }
        }
    }
    
    private func setupTopCloseButton() {
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .darkGray
        closeButton.addAction(UIAction { [unowned self] _ in
            dismiss(animated: true, completion: nil)
        }, for: .primaryActionTriggered)
        view.addSubview(closeButton)
    }
    
    private func setupTopRestoreButton() {
        restoreButton.setTitle("restore.button".localized, for: .normal)
        restoreButton.setTitleColor(.lightGray, for: .normal)
        restoreButton.titleLabel?.font = .systemFont(ofSize: 16)
        view.addSubview(restoreButton)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "alert.ok".localized, style: .default))
        present(alert, animated: true)
    }
    
    func createSlides() {
        let slidesArray: [Slide] = [
            .init(
                title: setupSlideAttributes(
                    "slide.1.prefix".localized,
                    highlight: "slide.1.highlight".localized,
                    suffix: "slide.1.suffix".localized
                ),
                image: UIImage(named: "payscreen-1")
            ),
            .init(
                title: setupSlideAttributes(
                    "slide.2.prefix".localized,
                    highlight: "slide.2.highlight".localized,
                    suffix: ""
                ),
                image: UIImage(named: "payscreen-2")
            ),
            .init(
                title: setupSlideAttributes(
                    "slide.3.prefix".localized,
                    highlight: "slide.3.highlight".localized,
                    suffix: ""
                ),
                image: UIImage(named: "payscreen-3")
            ),
            .init(
                title: setupSlideAttributes(
                    "slide.4.prefix".localized,
                    highlight: "slide.4.highlight".localized,
                    suffix: ""
                ),
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
        slideControllers = slides.map { SlideViewController(slide: $0) }
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
        
        configureBottomContainer()
        configurePriceLabels()
        configureSubscribeButton()
        configureTermsStack()
        addBottomSubviews()
    }
    
    private func configureBottomContainer() {
        bottomContainer.backgroundColor = AppColors.bottomContainerColor
    }
    
    private func configurePriceLabels() {
        priceLabel.text = "subscribe.priceLabel".localized
        priceLabel.font = .systemFont(ofSize: 16, weight: .medium)
        priceLabel.textColor = .white
        priceLabel.textAlignment = .center
        
        detailLabel.text = "subscribe.detailLabel".localized
        detailLabel.font = .systemFont(ofSize: 12)
        detailLabel.textColor = .white
        detailLabel.textAlignment = .center
    }
    
    private func configureSubscribeButton() {
        subscribeButton.setTitle("subscribe.button".localized, for: .normal)
        subscribeButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        subscribeButton.backgroundColor = AppColors.subscribeButtonColor
        subscribeButton.layer.cornerRadius = 28
        subscribeButton.setTitleColor(.white, for: .normal)
    }
    
    private func configureTermsStack() {
        let underlineAttr: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.white,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        termsButton.setAttributedTitle(
            NSAttributedString(string: "terms.of.use".localized, attributes: underlineAttr),
            for: .normal
        )
        privacyButton.setAttributedTitle(
            NSAttributedString(string: "privacy.policy".localized, attributes: underlineAttr),
            for: .normal
        )
        
        termsStack.axis = .horizontal
        termsStack.distribution = .fill
        termsStack.spacing = 150
        
        termsStack.addArrangedSubview(termsButton)
        termsStack.addArrangedSubview(privacyButton)
    }
    
    private func addBottomSubviews() {
        bottomContainer.addSubview(priceLabel)
        bottomContainer.addSubview(detailLabel)
        bottomContainer.addSubview(subscribeButton)
        bottomContainer.addSubview(termsStack)
    }
    
    private func layoutAll() {
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(24)
        }
        restoreButton.snp.makeConstraints { make in
            make.centerY.equalTo(closeButton)
            make.trailing.equalToSuperview().inset(16)
        }
        pageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(bottomContainer.snp.top)
        }
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(pageViewController.view.snp.bottom).offset(-20)
            make.centerX.equalToSuperview()
        }
        bottomContainer.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(view.bounds.height * 0.3)
            make.width.equalToSuperview()
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(36)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        subscribeButton.snp.makeConstraints { make in
            make.top.equalTo(detailLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(32)
            make.height.equalTo(56)
        }
        termsStack.snp.makeConstraints { make in
            make.top.equalTo(subscribeButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
    }
}

extension PayScreen: AnyScreen {
    func present(screen: UIViewController) {}
}
