//
//  HomeScreenCell.swift
//  payapp
//
//  Created by Georgy on 2025-07-04.
//

import UIKit

class HomeScreenCell: UICollectionViewCell {
    
    private weak var nameAgeLabel: UILabel?
    private weak var cellPhotoImage: UIImage?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
