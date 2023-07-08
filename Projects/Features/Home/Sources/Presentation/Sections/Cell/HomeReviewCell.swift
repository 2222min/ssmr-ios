//
//  HomeReviewCell.swift
//  Home
//
//  Created by 정건호 on 2023/07/08.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit
import CommonUI

open class HomeReviewCell: UICollectionViewCell {
    static let cellIdentifier = "HomeReviewCell"
    
    public let imageView = UIImageView().then {
        $0.layer.cornerRadius = 8
    }
    
    public let storeStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.backgroundColor = CommonUIAsset.pointColor.color
    }
    
    public let storeName = UILabel().then {
        $0.font = CoreTypo.Body3_B.style.font
        $0.textColor = CommonUIAsset.black.color
        $0.numberOfLines = 1
    }
    
    public let menuStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
    }
    
    public let menuName = UILabel().then {
        $0.font = CoreTypo.Caption1.style.font
        $0.textColor = CommonUIAsset.white.color
        $0.numberOfLines = 1
    }
    
    public let recommend = RightImageButton().then {
        $0.normalTitle = "추천".styled(
            typo: .Caption1,
            byAdding: [.color(CommonUIAsset.white.color)]
        )
        $0.normalImage = UIImage(asset: CommonUIAsset.awardImage) ?? UIImage()
        $0.titleEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: -2)
        $0.imageEdgeInsets = .init(top: 1, left: 0, bottom: 0, right: -2)
    }
    
    public let writer = UILabel().then {
        $0.font = CoreTypo.Caption1.style.font
        $0.textColor = CommonUIAsset.grey.color
        $0.numberOfLines = 1
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
        self.addSubview(storeStackView)
        self.addSubview(menuStackView)
        self.addSubview(writer)
        
        storeStackView.addArrangedSubview(UIView())
        storeStackView.addArrangedSubview(storeName)
        storeStackView.addArrangedSubview(UIView())
        menuStackView.addArrangedSubview(menuName)
        menuStackView.addArrangedSubview(recommend)
        setConstraints()
    }
    
    private func setConstraints() {
        self.imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.storeStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(88)
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.lessThanOrEqualToSuperview().offset(-12)
            $0.height.equalTo(24)
        }
        self.menuStackView.snp.makeConstraints {
            $0.top.equalTo(self.storeStackView.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.lessThanOrEqualToSuperview().offset(-19)
        }
        self.recommend.snp.makeConstraints {
            $0.width.equalTo(35)
        }
        self.writer.snp.makeConstraints {
            $0.top.equalTo(self.menuName.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(12)
        }
    }
    
    func configureCell(_ review: HomeReviewEntity) {
        self.storeName.text = review.storeName
        self.menuName.text = review.menuName
        self.writer.text = "by." + review.writer       
        self.imageView.kf.setImage(
            with: review.image,
            placeholder: UIImage(asset: CommonUIAsset.readyImage)
        )
    }
}

