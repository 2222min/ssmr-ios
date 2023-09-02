//
//  StoreInfoSectionViewController.swift
//  StoreInfo
//
//  Created by 정건호 on 2023/09/02.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit
import CommonUI
import Cosmos

/*
 TODO: 요일 UI, 버튼 subscribe
 */

class StoreInfoSectionViewController: BaseViewController {
    
    private let uiView = UIView().then {
        $0.layer.shadowColor = CommonUIAsset.mRed.color.cgColor
    }
    
    private let stackView = UIStackView().then {
        $0.backgroundColor = CommonUIAsset.white.color
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 24
        $0.layer.borderWidth = 1
        $0.layer.borderColor = CommonUIAsset.whiteGrey.color.cgColor
        $0.layer.cornerRadius = 14
    }
    
    private let headerStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .center
    }
    
    private let storeNameLabel = UILabel().then {
        $0.text = "애정마라탕"
        $0.font = CoreTypo.Subhead.style.font
        $0.textColor = CommonUIAsset.black.color
    }
    
    private let storeRatingStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 6
    }
    
    private let storeRatingView = CosmosView().then {
        $0.settings.fillMode = .precise
        $0.settings.starSize = 24
        $0.settings.starMargin = 0
        $0.settings.filledImage = CommonUIAsset.filledStar.image
        $0.settings.emptyImage = CommonUIAsset.unfilledStar.image
        $0.rating = 3.8
    }
    
    private let storeRatingLabel = UILabel().then {
        $0.text = "3.8"
        $0.font = CoreTypo.Subhead.style.font
        $0.textColor = CommonUIAsset.pointColor.color
    }
    
    private let reviewRatingCountLabel = UILabel().then {
        $0.text = "리뷰 \(8)"
        $0.font = CoreTypo.Caption2.style.font
        $0.textColor = CommonUIAsset.grey.color
    }
    
    private let lineImageView = UIImageView().then {
        $0.image = CommonUIAsset.line.image
    }
    
    private let bodyStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 16
    }
    
    private let tagButton = LeftImageButton().then {
        $0.normalTitle = "중식".styled(
            typo: .Body3,
            byAdding: [.color(CommonUIAsset.black.color)]
        )
        $0.normalImage = CommonUIAsset.tag.image
        $0.titleEdgeInsets = .init(top: 0, left: 40, bottom: 0, right: 0)
    }
    
    private let locationButton = LeftImageButton().then {
        $0.normalTitle = "서울 성북구 동소문로20나길 11".styled(
            typo: .Body3,
            byAdding: [.color(CommonUIAsset.black.color)]
        )
        $0.normalImage = CommonUIAsset.location.image
        $0.titleEdgeInsets = .init(top: 0, left: 40, bottom: 0, right: 0)
    }
    
    private let copyButton = UIButton().then {
        $0.setImage(CommonUIAsset.document.image, for: .normal)
    }
    
    private let callButton = LeftImageButton().then {
        $0.normalTitle = "0507-1413-3721".styled(
            typo: .Body3,
            byAdding: [.color(CommonUIAsset.black.color)]
        )
        $0.normalImage = CommonUIAsset.call.image
        $0.titleEdgeInsets = .init(top: 0, left: 40, bottom: 0, right: 0)
    }
    
    private let expandButton = LeftImageButton().then {
        $0.normalTitle = "정보 열기".styled(
            typo: .Body3,
            byAdding: [.color(CommonUIAsset.grey.color)]
        )
        $0.normalImage = CommonUIAsset.downArrow.image.withRenderingMode(.alwaysOriginal)
            .withTintColor(CommonUIAsset.grey.color)
        $0.titleEdgeInsets = .init(top: 4.5, left: 0, bottom: 0, right: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
    }
    
    override func configureUI() {
        super.configureUI()
        self.view.addSubview(uiView)
        self.uiView.addSubview(stackView)
        self.uiView.addSubview(copyButton)
        self.stackView.addArrangedSubview(headerStackView)
        self.stackView.addArrangedSubview(lineImageView)
        self.stackView.addArrangedSubview(bodyStackView)
        self.stackView.addArrangedSubview(expandButton)
        self.storeRatingStackView.addArrangedSubview(storeRatingView)
        self.storeRatingStackView.addArrangedSubview(storeRatingLabel)
        self.headerStackView.addArrangedSubview(storeNameLabel)
        self.headerStackView.addArrangedSubview(storeRatingStackView)
        self.headerStackView.addArrangedSubview(reviewRatingCountLabel)
        self.bodyStackView.addArrangedSubview(tagButton)
        self.bodyStackView.addArrangedSubview(locationButton)
        self.bodyStackView.addArrangedSubview(callButton)
        
        self.stackView.setCustomSpacing(18, after: lineImageView)
    }
    
    // MARK: Constraints
    override func setupConstraints() {
        super.setupConstraints()
        self.uiView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(self.view.snp.bottom)
        }
        self.stackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        self.headerStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32)
        }
        self.lineImageView.snp.makeConstraints {
            $0.top.equalTo(self.headerStackView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(50)
        }
        self.bodyStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(48)
        }
        self.copyButton.snp.makeConstraints {
            $0.top.equalTo(self.locationButton.snp.top).offset(-3)
            $0.leading.equalTo(self.locationButton.titleLabel?.snp.trailing ?? self.locationButton.snp.trailing).offset(4)
        }
    }
}
