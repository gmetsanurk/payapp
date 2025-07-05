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

class HomeScreenProfileCell: UICollectionViewCell {
    
    private weak var cellPhotoImageView: UIImageView?
    private weak var nameAgeLabel: UILabel?
    private weak var statusLabel: UILabel?
    private weak var countryLabel: UILabel?
    private weak var chatButton: UIButton?
    private weak var videoButton: UIButton?
    private weak var likeButton: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        setupNameAgeLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeScreenProfileCell {
    
    func setupCellPhotoImageView() {
        let photo = UIImageView()
        photo.contentMode = .scaleAspectFill
        photo.clipsToBounds = true
        contentView.addSubview(photo)
        self.cellPhotoImageView = photo
    }
    
    func setupNameAgeLabel() {
        let label = UILabel()
        contentView.addSubview(label)
        self.nameAgeLabel = label
    }
    
    func setupStatusLabel() {
        let status = UILabel()
        status.font = .systemFont(ofSize: 12)
        contentView.addSubview(status)
        self.statusLabel = status
    }
    
    func setupContryLabel() {
        let countryLbl = UILabel()
        countryLbl.font = .systemFont(ofSize: 12)
        countryLbl.textColor = .white
        contentView.addSubview(countryLbl)
        self.countryLabel = countryLbl
    }
    
    func setupChatButton() {
        let chatBtn = UIButton(type: .system)
        chatBtn.setImage(UIImage(systemName: "message.fill"), for: .normal)
        setupStyleForCellButtons(for: chatBtn)
        contentView.addSubview(chatBtn)
        self.chatButton = chatBtn
    }
    
    func setupVideoButton() {
        let videoBtn = UIButton(type: .system)
        videoBtn.setImage(UIImage(systemName: "video.fill"), for: .normal)
        setupStyleForCellButtons(for: videoBtn)
        contentView.addSubview(videoBtn)
        self.videoButton = videoBtn
    }
    
    func setupLikeButton() {
        let likeBtn = UIButton(type: .system)
        likeBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        setupStyleForCellButtons(for: likeBtn)
        contentView.addSubview(likeBtn)
        self.likeButton = likeBtn
    }
    
    func setupStyleForCellButtons(for button: UIButton) {
        button.backgroundColor = .white
        button.layer.cornerRadius = 14
        button.tintColor = .black
    }
    
    func setupLayout() {
        arrangeCellPhoto()
        arrangeNameAgeLabel()
        arrangeContryLabel()
        arrangeStatusLabel()
        arrangeLikeButton()
    }
    
}

extension HomeScreenProfileCell {
    
    func arrangeCellPhoto() {
        cellPhotoImageView?.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func arrangeNameAgeLabel() {
        nameAgeLabel?.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().inset(36)
        }
    }
    
    func arrangeContryLabel() {
        countryLabel?.snp.makeConstraints { make in
            let refView = nameAgeLabel ?? contentView
            let refBottom = nameAgeLabel?.snp.bottom ?? contentView.snp.bottom
            make.leading.equalTo(refView)
            make.top.equalTo(refBottom).offset(2)
        }
    }
    
    func arrangeStatusLabel() {
        statusLabel?.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(8)
            make.size.equalTo(CGSize(width: 28, height: 28))
        }
    }
    
    func arrangeLikeButton() {
        likeButton?.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(8)
            make.size.equalTo(CGSize(width: 28, height: 28))
        }
    }
}
