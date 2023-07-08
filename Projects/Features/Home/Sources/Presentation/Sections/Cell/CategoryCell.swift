//
//  CategoryCell.swift
//  HomeDemoApp
//
//  Created by 정건호 on 2023/05/02.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit
import CommonUI

open class CategoryCell: UICollectionViewCell {
    static let cellIdentifier = "CategoryCell"
    
    public let catrgoryButton = UIButton().then {
        $0.setBackgroundColor(color: CommonUIAsset.white.color, forState: .normal)
        $0.setBackgroundColor(color: CommonUIAsset.pointColor.color, forState: .selected)
        $0.titleEdgeInsets = .init(top: 0, left: 0, bottom: 2.5, right: 0)
        $0.layer.cornerRadius = 16
        $0.layer.borderWidth = 1
        $0.layer.borderColor = CommonUIAsset.whiteGrey.color.cgColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.addSubview(catrgoryButton)
        setConstraints()
    }
    
    private func setConstraints() {
        self.catrgoryButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(32)
        }
    }
    
    func setCategoryButtonTitle(_ text: String) {
        self.catrgoryButton.setAttributedTitle(
            text.styled(
                typo: .Body3_B,
                byAdding: [.color(CommonUIAsset.grey.color)]
            ),
            for: .normal
        )
        self.catrgoryButton.setAttributedTitle(
            text.styled(
                typo: .Body3_B,
                byAdding: [.color(CommonUIAsset.white.color)]
            ),
            for: .selected
        )
    }
}
