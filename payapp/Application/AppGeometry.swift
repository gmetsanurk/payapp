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
    
}
