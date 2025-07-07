//
//  PayWallScreen.swift
//  payapp
//
//  Created by Georgy on 2025-07-07.
//
import UIKit
import Adapty

typealias SelectCellScreenHandler = () -> Void

class PaywallScreen: UIViewController {
    
    var onCellSelected: SelectCellScreenHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

extension PaywallScreen: AnyScreen {
    func present(screen: UIViewController) {}
}
