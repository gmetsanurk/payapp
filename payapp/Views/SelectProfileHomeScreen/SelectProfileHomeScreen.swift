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
        layout.itemSize = .init(width: itemWidth, height: 200)
        layout.minimumLineSpacing = Constants.padding
        layout.sectionInset = .init(top: Constants.padding, left: Constants.padding, bottom: Constants.padding, right: Constants.padding)
        
        let profilesList = SelectProfileHomeCollectionView<HomeScreenProfileCell, CellDataType>(
            frame: .zero, collectionViewLayout: layout,
            handler: {
            [unowned self] in
                onCellSelected()
        })
        profilesList.backgroundColor = .white
        view.addSubview(profilesList)
        self.selectProfilesList = profilesList
    }
    
    private var itemWidth: CGFloat {
        view.bounds.width/CGFloat(Constants.itemsPerLine) - Constants.padding * 2
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        (selectProfilesList?.collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize = .init(width: itemWidth, height: 200)
    }
    
    func setupHeaderView() {
        headerView.backgroundColor = .clear
        view.addSubview(headerView)
    }
    
    func setupTitleLabel() {
        // TODO: localize
        titleLabel.text = "Feed"
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
        let items = ["Online", "Popular", "New", "Following"]
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
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(segmentedControl.snp.bottom).offset(Constants.padding/2.0)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(Constants.padding)
        }
        coinsButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalToSuperview().inset(Constants.padding)
        }
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(Constants.padding)
        }
        
        selectProfilesList?.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension SelectProfileHomeScreen: AnyScreen { }
