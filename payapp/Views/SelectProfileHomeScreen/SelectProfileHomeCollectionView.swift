//
//  HomeScreenCollectionView.swift
//  payapp
//
//  Created by Georgy on 2025-07-04.
//

import UIKit
import SnapKit

typealias HomeCollectionViewDataHandler = () -> Void

class SelectProfileHomeCollectionView<CellType: UICollectionViewCell & CustomizableCell, DataType>: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var data: [DataType] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.reloadData()
            }
        }
    }
    
    private var handler: HomeCollectionViewDataHandler?
    init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout, handler: SelectCellScreenHandler?) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.handler = handler

        register(CellType.self, forCellWithReuseIdentifier: "cell")
        dataSource = self
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        Task { @MainActor in
            await (cell as? CustomizableCell)?.configure(with: data[indexPath.item] as! CellDataType)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handler?()
    }
}
