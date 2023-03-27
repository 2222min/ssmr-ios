//
//  NotiTypeCell.swift
//  Notification
//
//  Created by 정건호 on 2023/03/27.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit
import CommonUI

open class NotiTypeCell: UICollectionViewCell {
    static let cellIdentifier = "NotiTypeCell"
    
    public let typeButton = UIButton().then {
        $0.setBackgroundColor(color: CommonUIAsset.whiteGrey.color, forState: .normal)
        $0.setBackgroundColor(color: CommonUIAsset.pointColor.color, forState: .selected)
        $0.titleEdgeInsets = .init(top: 0, left: 0, bottom: 4, right: 0)
        $0.layer.cornerRadius = 18
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required public init?(coder: NSCoder) { 
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.addSubview(typeButton)
        setConstraints()
    }
    
    private func setConstraints() {
        self.typeButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(36)
            $0.top.bottom.equalToSuperview().inset(6)
        }
    }
    
    func setTypeButtonTitle(_ text: String) {
        self.typeButton.setAttributedTitle(
            text.styled(
                typo: .DDaengMB2,
                byAdding: [.color(CommonUIAsset.grey.color)]
            ),
            for: .normal
        )
        self.typeButton.setAttributedTitle(
            text.styled(
                typo: .DDaengMB2,
                byAdding: [.color(CommonUIAsset.white.color)]
            ),
            for: .selected
        )
    }
}
