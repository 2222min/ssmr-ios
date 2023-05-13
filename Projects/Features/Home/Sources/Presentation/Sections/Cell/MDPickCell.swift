//
//  MDPickCell.swift
//  HomePresentation
//
//  Created by 정건호 on 2023/04/29.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit
import CommonUI
import Kingfisher

open class MDPickCell: UICollectionViewCell {
    static let cellIdentifier = "MDPickCell"
    
    public let imageView = UIImageView().then {
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .gray
    }
    
    public let title = UILabel().then {
        $0.text = "테스트"
        $0.font = CoreTypo.ButtonLarge.style.font
        $0.textColor = CommonUIAsset.black.color
        $0.numberOfLines = 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.addSubview(imageView)
        self.addSubview(title)
        setConstraints()
    }
    
    private func setConstraints() {
        self.imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.title.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-12)
            $0.bottom.equalToSuperview().offset(-8)
        }
    }
    
    func setImage(_ url: String) {
        guard let url = URL(string: url) else { return }
        self.imageView.kf.setImage(with: url)
    }
}
