//
//  StoreInfoViewController.swift
//  StoreInfoPresentation
//
//  Created by 정건호 on 2023/07/30.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit

import CommonUI
import Util
import Kingfisher

class StoreInfoViewController: BaseViewController {
    
    private let storeImageView = UIImageView()
    private let opacityView = UIView().then {
        $0.backgroundColor = CommonUIAsset.black.color
        $0.layer.opacity = 0.5
    }
    
    private let storeNameStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 16
        $0.alignment = .leading
        $0.layer.zPosition = 1
    }
    
    private let pageIcon = UIButton().then {
        $0.setTitle("떙땡 가게", for: .normal)
        $0.setTitleColor(CommonUIAsset.pointColor.color, for: .normal)
        $0.titleLabel?.font = CoreTypo.Caption1.style.font
        $0.contentEdgeInsets = UIEdgeInsets(top: 6, left: 14, bottom: 6, right: 14)
        $0.layer.cornerRadius = 14
        $0.layer.borderColor = CommonUIAsset.pointColor.color.cgColor
        $0.layer.borderWidth = 1
    }
    
    private let storeNameLabel = UILabel().then {
        $0.textColor = CommonUIAsset.white.color
        $0.font = CoreTypo.Display.style.font
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        super.configureUI()
        setNavigationTopBar()
        setStoreImageView()
        setStoreNameLabel()
        
        self.view.addSubview(storeImageView)
        self.storeImageView.addSubview(storeNameStackView)
        self.storeImageView.addSubview(opacityView)
        self.storeNameStackView.addArrangedSubview(pageIcon)
        self.storeNameStackView.addArrangedSubview(storeNameLabel)
    }
    
    // MARK: Constraints
    override func setupConstraints() {
        super.setupConstraints()
        self.storeImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(400)
        }
        self.storeNameStackView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(72)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        self.opacityView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setNavigationTopBar() {
        navigationTopBar.titleLabel.text = "가게 정보"
        navigationTopBar.titleLabel.textColor = .white
        navigationTopBar.leftButton.setImage(CommonUIAsset.backButton.image, for: .normal)
        navigationTopBar.rightButton.setImage(CommonUIAsset.bookmark.image, for: .normal)
        navigationTopBar.layer.zPosition = 1
    }
    
    func setStoreImageView() {
        self.storeImageView.kf.setImage(
            with: URL(string: "Test"),
            placeholder: CommonUIAsset.storeInfoTestImage.image
        )
    }
    
    func setStoreNameLabel() {
        self.storeNameLabel.text = "애정 마라탕"
    }
}