//
//  HomeScreenCell.swift
//  payapp
//
//  Created by Georgy on 2025-07-04.
//

import UIKit
import SnapKit

protocol CustomizableCell {
    
}

class HomeScreenCell: UICollectionViewCell {
    
    private weak var nameAgeLabel: UILabel?
    private weak var cellPhotoImage: UIImage?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        createNameAgeLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeScreenCell {
    
    func createNameAgeLabel() {
        let label = UILabel()
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        nameAgeLabel = label
    }
}
