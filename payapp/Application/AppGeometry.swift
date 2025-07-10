//
//  AppGeometry.swift
//  payapp
//
//  Created by Georgy on 2025-07-10.
//

import Foundation

struct AppGeometry {
    
    struct SelectProfileHome {
        static let padding: CGFloat = 16
        static let itemsPerLine: Int = 2
        static let cellHeight: CGFloat = 200
        static let segmentedTopOffset: CGFloat = 12
        static let headerBottomOffsetMultiplier: CGFloat = 0.5
    }
    
    struct FeedCard {
        static let commonInset: CGFloat = 8
        static let buttonSize: CGSize = CGSize(width: 28, height: 28)
        static let flagLabelBottomInset: CGFloat = 36
    }
    
    struct PayScreen {
        static let sideInset: CGFloat = 16
        static let closeButtonSize: CGFloat = 24
        static let closeTopOffset: CGFloat = 16
        static let closeToPageOffset: CGFloat = 8
        static let pageControlOffset: CGFloat = -20
        static let bottomContainerHeightMultiplier: CGFloat = 0.3
        
        static let priceTopOffset: CGFloat = 36
        static let priceToDetailOffset: CGFloat = 4
        static let detailToSubscribeOffset: CGFloat = 24
        static let subscribeHeight: CGFloat = 56
        static let subscribeSideInset: CGFloat = 32
        static let subscribeToTermsOffset: CGFloat = 16
        
        static let termsSpacing: CGFloat = 150
        static let termsFontSize: CGFloat = 12
        static let subscribeCornerRadius: CGFloat = 28
        static let slideTitleFontSize: CGFloat = 24
    }
}
