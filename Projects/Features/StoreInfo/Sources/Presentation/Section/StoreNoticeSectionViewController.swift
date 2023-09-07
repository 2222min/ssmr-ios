//
//  StoreNoticeSectionViewController.swift
//  StoreInfo
//
//  Created by 정건호 on 2023/09/07.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit
import CommonUI


// TODO: 클릭 이벤트 추가하기;
class StoreNoticeSectionViewController: BaseViewController {
    
    private let uiView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = CommonUIAsset.whiteGrey.color.cgColor
        $0.layer.cornerRadius = 14
    }
    
    private let imageView = UIImageView().then {
        $0.image = UIImage(asset: CommonUIAsset.heartBalloon)
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "사장님의 한마디"
        $0.font = CoreTypo.Body3_B.style.font
        $0.textColor = CommonUIAsset.black.color
    }
    
    private let subTitleLabel = UILabel().then {
        $0.text = "확인해볼까요?"
        $0.font = CoreTypo.Caption1.style.font
        $0.textColor = CommonUIAsset.grey.color
    }
    
    override func configureUI() {
        super.configureUI()
        self.view.backgroundColor = CommonUIAsset.cream.color
        self.view.addSubview(uiView)
        self.uiView.addSubview(imageView)
        self.uiView.addSubview(titleLabel)
        self.uiView.addSubview(subTitleLabel)
    }
    
    // MARK: Constraints
    override func setupConstraints() {
        super.setupConstraints()
        self.uiView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(68)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(self.view.snp.bottom)
        }
        self.imageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.imageView.snp.top)
            $0.leading.equalTo(self.imageView.snp.trailing).offset(24)
        }
        self.subTitleLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.imageView.snp.bottom)
            $0.leading.equalTo(self.imageView.snp.trailing).offset(24)
        }
    }
}
