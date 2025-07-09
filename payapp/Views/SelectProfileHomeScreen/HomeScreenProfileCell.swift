//
//  HomeScreenProfileCell.swift
//  payapp
//
//  Created by Georgy on 2025-07-04.
//

import UIKit
import SnapKit

protocol CustomizableCell {
    @MainActor
    func configure(with data: CellDataType) async
}

class HomeScreenProfileCell: UICollectionViewCell, CustomizableCell {
    private unowned var cellPhotoImageView: UIImageView!
    private unowned var statusImageView: UIImageView!
    private unowned var flagNameAgeLabel: UILabel!
    private unowned var chatButton: UIButton!
    private unowned var videoButton: UIButton!
    private unowned var likeButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        setupUIElements()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeScreenProfileCell {
    @MainActor
    func configure(with data: CellDataType) async {
        guard
            let name = data.name,
            let age = data.age,
            let flag = data.flag
        else {
            let displayName = data.name ?? "–"
            let displayAge  = data.age.map(String.init) ?? "–"
            let displayFlag = data.flag ?? "-"
            flagNameAgeLabel?.text = "\(displayFlag) \(displayName), \(displayAge)"
            return
        }
        cellPhotoImageView.image = UIImage(named: data.imageName ?? "")
        statusImageView.image = UIImage(named: data.statusText ?? "offline")
        flagNameAgeLabel.text = "\(flag) \(name), \(age)"
    }
    
    func setupUIElements() {
        setupCellPhotoImageView()
        setupStatusImageView()
        setupFlagNameAgeLabel()
        setupCellButtons()
    }
    
    private func setupCellButtons() {
        chatButton = setupCellButton(named: "chat-label")
        videoButton =  setupCellButton(named: "btn-live")
        likeButton =  setupCellButton(named: "favorite-1")
    }
    
    func setupCellPhotoImageView() {
        let photo = UIImageView()
        photo.contentMode = .scaleAspectFill
        photo.clipsToBounds = true
        photo.layer.cornerRadius = 15
        contentView.addSubview(photo)
        self.cellPhotoImageView = photo
    }
    
    func setupStatusImageView() {
        let photo = UIImageView()
        photo.contentMode = .scaleAspectFill
        photo.clipsToBounds = true
        contentView.addSubview(photo)
        self.statusImageView = photo
    }
    
    func setupFlagNameAgeLabel() {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        contentView.addSubview(label)
        self.flagNameAgeLabel = label
    }
    
    private func setupCellButton(
        named imageName: String,
        configurator: ((UIButton) -> Void)? = nil
    ) -> UIButton {
        let button = UIButton(type: .system)
        let image = UIImage(named: imageName)?
            .withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 14
        button.tintColor = .white
        configurator?(button)
        contentView.addSubview(button)
        return button
    }
    
}

extension HomeScreenProfileCell {
    
    func setupLayout() {
        arrangeCellPhoto()
        arrangeStatus()
        arrangeFlagNameAgeLabel()
        arrangeChatButton()
        arrangeVideoButton()
        arrangeLikeButton()
    }
    
    func arrangeCellPhoto() {
        cellPhotoImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func arrangeStatus() {
        statusImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(8)
        }
    }
    
    func arrangeFlagNameAgeLabel() {
        flagNameAgeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(36)
        }
    }
    
    func arrangeChatButton() {
        chatButton.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(8)
            make.size.equalTo(CGSize(width: 28, height: 28))
        }
    }
    
    func arrangeVideoButton() {
        videoButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(8)
            make.size.equalTo(CGSize(width: 28, height: 28))
        }
    }
    
    func arrangeLikeButton() {
        likeButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(8)
            make.size.equalTo(CGSize(width: 28, height: 28))
        }
    }
}
