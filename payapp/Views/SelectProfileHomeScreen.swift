//
//  ViewController.swift
//  payapp
//
//  Created by Georgy on 2025-07-04.
//

import UIKit

typealias CellDataType = ProfileModel
class SelectProfileHomeScreen: UIViewController {
    
    private weak var selectProfilesList:  SelectProfileHomeCollectionView<HomeScreenProfileCell, CellDataType>?
    
    private lazy var presenter = HomePresenter(view: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .init(width: view.bounds.width - 32, height: 200)
        layout.minimumLineSpacing = 16
        layout.sectionInset = .init(top: 16, left: 16, bottom: 16, right: 16)
        
        let profilesList = SelectProfileHomeCollectionView<HomeScreenProfileCell, CellDataType>(frame: .zero, collectionViewLayout: layout)
        profilesList.backgroundColor = .white
        view.addSubview(profilesList)
        self.selectProfilesList = profilesList
        profilesList.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        DispatchQueue.main.async { [weak self] in
            self?.presenter.loadProfiles()
        }
    }
    
    func displayProfiles(_ profiles: [CellDataType]) {
        selectProfilesList?.data = profiles
    }

}

