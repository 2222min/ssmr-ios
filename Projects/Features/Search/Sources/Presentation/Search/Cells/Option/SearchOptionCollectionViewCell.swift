//
//  SearchOptionCollectionViewCell.swift
//  Search
//
//  Created mincheol on 2023/08/27.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit
import Then
import SnapKit
import RxCocoa
import RxSwift
import ReactorKit
import CommonUI

final class SearchOptionCollectionViewCell: BaseCollectionViewCell, ReactorKit.View {


	// MARK: Constants
	private enum Constants {
        static let nearestButtonTitle = "가까운 순"
            .styled(
                typo: .Caption1_B,
                byAdding: [.color(CommonUIAsset.deepGrey.color)]
            )
        static let nearestButtonSelectedTitle = "가까운 순"
            .styled(
                typo: .Caption1_B,
                byAdding: [.color(CommonUIAsset.white.color)]
            )
        static let popularityButtonTitle = "인기 순"
            .styled(
                typo: .Caption1_B,
                byAdding: [.color(CommonUIAsset.deepGrey.color)]
            )
        static let popularityButtonSelectedTitle = "인기 순"
            .styled(
                typo: .Caption1_B,
                byAdding: [.color(CommonUIAsset.white.color)]
            )
    }

	// MARK: Propertie

	// MARK: UI Properties
    private let nearestButton: UIButton = UIButton()
    private let popularityButton: UIButton = UIButton()

	// MARK: Initializing

	override func prepareForReuse() {
		super.prepareForReuse()
	}
	
	func configure(reactor: SearchOptionCellReactor) {
		super.configure()
		self.reactor = reactor
	}


	// MARK: UI
	override func configureUI() {
		super.configureUI()
        [
            self.nearestButton,
            self.popularityButton
        ]
            .forEach(self.addSubview)
	}

	// MARK: Constraints
	override func setupConstraints() {
		super.setupConstraints()
        self.nearestButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().inset(20)
            $0.width.equalTo(61)
            $0.height.equalTo(32)
        }
        self.popularityButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(24)
            $0.width.equalTo(51)
            $0.height.equalTo(32)
        }
	}

	// MARK: ReactorBind
	func bind(reactor: SearchOptionCellReactor) {}
}
