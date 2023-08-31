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
    
    private let storeImageSection = StoreImageSectionViewController()
    
    // MARK: UI Properties
    
    private let scrollView = UIScrollView().then {
        $0.backgroundColor = .white
    }
    
    private let container = UIStackView().then {
        $0.backgroundColor = .white
        $0.axis = .vertical
        $0.spacing = 36
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(container)
        [
            self.storeImageSection.view
        ].forEach(self.container.addArrangedSubview)
    }
    
    override func configureUI() {
        super.configureUI()
        setNavigationTopBar()
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(container)
        [
            self.storeImageSection.view
        ].forEach(self.container.addArrangedSubview)
    }
    
    // MARK: Constraints
    override func setupConstraints() {
        super.setupConstraints()
        self.scrollView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        self.container.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(self.scrollView)
        }
    }
    
    private func setNavigationTopBar() {
        navigationTopBar.titleLabel.text = "가게 정보"
        navigationTopBar.titleLabel.textColor = .white
        navigationTopBar.leftButton.setImage(CommonUIAsset.backButton.image, for: .normal)
        navigationTopBar.rightButton.setImage(CommonUIAsset.bookmark.image, for: .normal)
        navigationTopBar.layer.zPosition = 1
    }
}
