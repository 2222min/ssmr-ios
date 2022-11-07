//
//  LabelWithCategory.swift
//  CommonUI
//
//  Created by 정건호 on 2022/11/06.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit
import RxCocoa

/*
 Ex) let category = LabelWithCategory().then {
    $0.category.setAttributedTitle(Constants.categoryText, for: .normal)
    $0.category.setAttributedTitle(Constants.categoryText, for: .selected)
}

 // height 값을 할당해줘야 button 사용 가능
 category.snp.makeConstraints {
    $0.height.equalTo(24)
 }
 */

public class LabelWithCategory: UIView {
    
    public let category = RightImageButton().then {
        $0.normalImage = UIImage(asset: CommonUIAsset.chevronDown) ?? UIImage()
        $0.selectedImage = UIImage(asset: CommonUIAsset.chevronDownSelected) ?? UIImage()
        $0.imageEdgeInsets = .init(top: 6, left: 0, bottom: 0, right: -10)
        $0.titleEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: -4)
    }
    
    public let label = UILabel().then {
        $0.textColor = CommonUIAsset.black.color
    }
    
    public let underline = UIView().then {
        $0.backgroundColor = CommonUIAsset.whiteGrey.color
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(category)
        addSubview(label)
        addSubview(underline)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        category.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(8)
        }
        label.snp.makeConstraints {
            $0.bottom.equalTo(self.category.snp.bottom)
            $0.leading.equalTo(category.snp.trailing).offset(24)
        }
        underline.snp.makeConstraints {
            $0.top.equalTo(category.snp.bottom).offset(6)
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview()
        }
    }
}


