//
//  HomeScreenCollectionView.swift
//  payapp
//
//  Created by Georgy on 2025-07-04.
//

import UIKit

class HomeScreenCollectionView<CellType: UICollectionViewCell>: UICollectionView, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 // MARK: Count the number of cells later
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}
