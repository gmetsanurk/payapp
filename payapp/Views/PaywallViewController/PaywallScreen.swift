//
//  PayWallScreen.swift
//  payapp
//
//  Created by Georgy on 2025-07-07.
//
import UIKit

protocol SelectPaywallScreenDelegate: AnyObject {
    func onCellSelected()
}

typealias SelectCellScreenHandler = () -> Void

class PaywallScreen: UIViewController {
    
    var onCellSelected: SelectCellScreenHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

extension PaywallScreen: CollectionViewSelectDelegate {
    func onSelected() {
        
    }
    
}
