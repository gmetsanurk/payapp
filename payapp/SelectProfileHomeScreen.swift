//
//  ViewController.swift
//  payapp
//
//  Created by Georgy on 2025-07-04.
//

import UIKit

class SelectProfileHomeScreen: UIViewController {
    
    private weak var selectProfilesList:  SelectProfileHomeCollectionView<HomeScreenProfileCell>?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 100, height: 100)
        
        let profilesList = SelectProfileHomeCollectionView<HomeScreenProfileCell>(frame: .zero, collectionViewLayout: layout)
        profilesList.backgroundColor = .red
        view.addSubview(profilesList)
        self.selectProfilesList = profilesList
        profilesList.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }

}

