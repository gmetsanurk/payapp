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
    
    private weak var nameAgeLabel: UILabel?
    private weak var cellPhotoImageView: UIImageView?
    private weak var statusLabel: UILabel?
    private weak var chatButton: UIButton?
    private weak var videoButton: UIButton?
    private weak var likeButton: UIButton?
    private weak var countryLabel: UIButton?
    
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
    
    func setupNameAgeLabel() {
        let label = UILabel()
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.nameAgeLabel = label
    }
    
    func setupCellPhotoImageView() {
        let photo = UIImageView()
        photo.contentMode = .scaleAspectFill
        photo.clipsToBounds = true
        contentView.addSubview(photo)
        self.cellPhotoImageView = photo
    }
    
    func setupStatusLabel() {
        let status = UILabel()
        status.font = .systemFont(ofSize: 12)
        contentView.addSubview(status)
        self.statusLabel = status
    }
    
    func setupChatButton() {
        let chatBtn = UIButton(type: .system)
        chatBtn.setImage(UIImage(systemName: "message.fill"), for: .normal)
        setupSettingForCellButtons(for: chatBtn)
        contentView.addSubview(chatBtn)
        self.chatButton = chatBtn
    }
    
    func setupVideoButton() {
        let videoBtn = UIButton(type: .system)
        videoBtn.setImage(UIImage(systemName: "video.fill"), for: .normal)
        setupSettingForCellButtons(for: videoBtn)
        contentView.addSubview(videoBtn)
        self.videoButton = videoBtn
    }
    
    func setupLikeButton() {
        let likeBtn = UIButton(type: .system)
        likeBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        setupSettingForCellButtons(for: likeBtn)
        contentView.addSubview(likeBtn)
        self.likeButton = likeBtn
    }
    
    func setupSettingForCellButtons(for button: UIButton) {
        button.backgroundColor = .white
        button.layer.cornerRadius = 14
        button.tintColor = .black
    }
}
