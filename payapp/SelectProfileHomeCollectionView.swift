//
//  HomeScreenCollectionView.swift
//  payapp
//
//  Created by Georgy on 2025-07-04.
//

import UIKit
import SnapKit

class SelectProfileHomeCollectionView<CellType: UICollectionViewCell>: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)

        register(CellType.self, forCellWithReuseIdentifier: "cell")
        dataSource = self
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4 // MARK: Count the number of cells later
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        //(cell as? CustomizableCell)?.setup(with: data[indexPath.item])
        return cell
    }
    
    
}
