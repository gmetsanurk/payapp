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
    
    private var paywall: AdaptyPaywall!
    private var products: [AdaptyPaywallProduct] = []
    private unowned var subscriveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
}

extension PaywallScreen: AnyScreen {
    func present(screen: UIViewController) {}
}
