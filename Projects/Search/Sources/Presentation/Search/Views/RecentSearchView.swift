//
//  RecentSearchView.swift
//  Presentation
//
//  Created by mincheol on 2023/04/11.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit
import Then
import SnapKit
import CommonUI

class RecentSearchView: UIView {
    
    // MARK: UIProperties
    private let headerContainer: UIView = UIView()
    private let headerLabel: UILabel = UILabel().then {
        $0.attributedText = "최근 검색어".styled(
            typo: CoreTypo.DDaengMB3_Regular,
            byAdding: [.color(CommonUIAsset.grey.color)])
    }
    private let totalDeleteButton: UIButton = UIButton().then {
        $0.setAttributedTitle(
            "전체삭제".styled(
                typo: CoreTypo.DDaengMB3_Regular,
                byAdding: [.color(CommonUIAsset.grey.color)]
            ), for: .normal)
    }
//    private let collectionView: UICollectionView = UICollectionView()
    
    init() {
        super.init(frame: .zero)
        
        self.configureUI()
        self.setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        [
            self.headerLabel,
            self.totalDeleteButton
        ]
            .forEach {
                self.headerContainer.addSubview($0)
            }
        self.addSubview(self.headerContainer)
    }
    
    private func setConstraints() {
        self.headerContainer.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
        self.headerLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        self.totalDeleteButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
    }
}
