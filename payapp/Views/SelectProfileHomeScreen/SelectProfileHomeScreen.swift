//
//  SelectProfileHomeScreen:.swift
//  payapp
//
//  Created by Georgy on 2025-07-04.
//

import UIKit

typealias CellDataType = ProfileModel

final class SelectProfileHomeScreen: UIViewController {
    
    private let headerView = UIView()
    private let titleLabel = UILabel()
    private let coinsButton = UIButton(type: .custom)
    private var segmentedControl = UISegmentedControl()
    
    struct Constants {
        static let itemsPerLine = 2
        static let padding: CGFloat = 16
    }
    
    private weak var selectProfilesList:  SelectProfileHomeCollectionView<HomeScreenProfileCell, CellDataType>?
    
    private lazy var viewModel = HomeViewModel(view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        createSegmentedControl()
        createProfilesList()
        makeConstraints()
        
        viewModel.loadProfiles()
    }
    
    func displayProfiles(_ profiles: [CellDataType]) {
        selectProfilesList?.data = profiles
    }
    
    func onCellSelected() {
        viewModel.handleSelect()
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
        layout.itemSize = .init(width: itemWidth, height: AppGeometry.SelectProfileHome.cellHeight)
        layout.minimumLineSpacing = AppGeometry.SelectProfileHome.padding
        layout.sectionInset = .init(
            top: AppGeometry.SelectProfileHome.padding,
            left: AppGeometry.SelectProfileHome.padding,
            bottom: AppGeometry.SelectProfileHome.padding,
            right: AppGeometry.SelectProfileHome.padding
        )
        
        let profilesList = SelectProfileHomeCollectionView<HomeScreenProfileCell, CellDataType>(
            frame: .zero,
            collectionViewLayout: layout,
            handler: { [unowned self] in onCellSelected() }
        )
        
        profilesList.backgroundColor = .white
        view.addSubview(profilesList)
        self.selectProfilesList = profilesList
    }
    
    private var itemWidth: CGFloat {
        let padding = AppGeometry.SelectProfileHome.padding
        return view.bounds.width / CGFloat(AppGeometry.SelectProfileHome.itemsPerLine) - padding * 2
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        (selectProfilesList?.collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize = .init(
            width: itemWidth,
            height: AppGeometry.SelectProfileHome.cellHeight
        )
    }
    
    func setupHeaderView() {
        headerView.backgroundColor = .clear
        view.addSubview(headerView)
    }
    
    func setupTitleLabel() {
        titleLabel.text = "feed.title".localized
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = .black
        headerView.addSubview(titleLabel)
    }
    
    func setupCoinsButton() {
        let coinsImage = UIImage(named: "label-coins")?.withRenderingMode(.alwaysOriginal)
        coinsButton.setImage(coinsImage, for: .normal)
        coinsButton.imageView?.contentMode = .scaleAspectFit
        headerView.addSubview(coinsButton)
    }
    
    private func setupSegmentedControl() -> UISegmentedControl {
        let items = [
            "feed.segment.online".localized,
            "feed.segment.popular".localized,
            "feed.segment.new".localized,
            "feed.segment.following".localized
        ]
        let sc = UISegmentedControl(items: items)
        sc.backgroundColor = .clear
        sc.selectedSegmentTintColor = .white
        let blackAttrs: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black
        ]
        sc.setTitleTextAttributes(blackAttrs, for: .normal)
        sc.setTitleTextAttributes(blackAttrs, for: .selected)
        sc.layer.borderWidth = 0
        sc.selectedSegmentIndex = 0
        return sc
    }
    
    func makeConstraints() {
        let padding = AppGeometry.SelectProfileHome.padding
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(segmentedControl.snp.bottom).offset(padding * AppGeometry.SelectProfileHome.headerBottomOffsetMultiplier)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(padding)
        }
        
        coinsButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalToSuperview().inset(padding)
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(AppGeometry.SelectProfileHome.segmentedTopOffset)
            make.leading.trailing.equalToSuperview().inset(padding)
        }
        
        selectProfilesList?.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}


extension SelectProfileHomeScreen: AnyScreen { }
