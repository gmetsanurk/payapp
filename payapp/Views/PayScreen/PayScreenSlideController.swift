//
//  PayScreenSlideController.swift
//  payapp
//
//  Created by Georgy on 2025-07-10.
//

import UIKit

struct Slide {
    let title: NSAttributedString
    let image: UIImage?
}

final class SlideViewController: UIViewController {
    
    private let slide: Slide
    private let imageView = UIImageView()
    private let label     = UILabel()

    init(slide: Slide) {
        self.slide = slide
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.addSubview(imageView)
        configureUI()
        layoutUI()
    }

    private func configureUI() {
        imageView.image = slide.image
        imageView.contentMode = .scaleAspectFit
        label.attributedText = slide.title
        label.numberOfLines = 0
        label.textAlignment = .center
    }

    private func layoutUI() {
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.leading.trailing.equalToSuperview().inset(32)
        }
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(imageView.snp.width)
        }
    }
}
