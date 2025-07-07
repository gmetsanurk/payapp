//
//  ViewController.swift
//  payapp
//
//  Created by Georgy on 2025-07-04.
//

import UIKit

typealias CellDataType = ProfileModel
typealias SelectCellScreenHandler = () -> Void

class SelectProfileHomeScreen: UIViewController {
    
    private let headerView = UIView()
    private let titleLabel = UILabel()
    private let coinsButton = UIButton(type: .custom)
    private var segmentedControl = UISegmentedControl()
    
    var onCellSelected: SelectCellScreenHandler?
    
    private weak var selectProfilesList:  SelectProfileHomeCollectionView<HomeScreenProfileCell, CellDataType>?
    
    private lazy var presenter = HomePresenter(view: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        createSegmentedControl()
        createProfilesList()
        makeConstraints()
        
        DispatchQueue.main.async { [weak self] in
            self?.presenter.loadProfiles()
        }
    }
    
    func displayProfiles(_ profiles: [CellDataType]) {
        selectProfilesList?.data = profiles
    }
    
}

extension SelectProfileHomeScreen {
    func setupUI() {
        setupHeaderView()
        setupTitleLabel()
        setupCoinsButton()
    }
    
    func createSegmentedControl() {
        segmentedControl = setupSegmentedControl()
        headerView.addSubview(segmentedControl)
    }
    
    func createProfilesList() {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .init(width: view.bounds.width - 32, height: 200)
        layout.minimumLineSpacing = 16
        layout.sectionInset = .init(top: 16, left: 16, bottom: 16, right: 16)
        
        let profilesList = SelectProfileHomeCollectionView<HomeScreenProfileCell, CellDataType>(frame: .zero, collectionViewLayout: layout)
        profilesList.backgroundColor = .white
        view.addSubview(profilesList)
        self.selectProfilesList = profilesList
        
    }
    
    func setupHeaderView() {
        headerView.backgroundColor = .clear
        view.addSubview(headerView)
    }
    
    func setupTitleLabel() {
        titleLabel.text = "Feed"
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        headerView.addSubview(titleLabel)
        
    }
    
    func setupCoinsButton() {
        let coinsImage = UIImage(named: "label-coins")?.withRenderingMode(.alwaysOriginal)
        coinsButton.setImage(coinsImage, for: .normal)
        coinsButton.imageView?.contentMode = .scaleAspectFit
        headerView.addSubview(coinsButton)
    }
    
    private func setupSegmentedControl() -> UISegmentedControl {
        let items = ["Online", "Popular", "New", "Following"]
        let sc = UISegmentedControl(items: items)
        sc.backgroundColor = .clear
        sc.selectedSegmentTintColor = .white
        sc.layer.borderWidth = 0
        sc.selectedSegmentIndex = 0
        return sc
    }
    
    func makeConstraints() {
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(segmentedControl.snp.bottom).offset(8)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
        }
        coinsButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalToSuperview().inset(16)
        }
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        selectProfilesList?.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

