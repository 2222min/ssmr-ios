//
//  TopSearchHeaderCollectionViewCell.swift
//  Search
//
//  Created mincheol on 2023/08/27.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit

import UIKit
import Then
import SnapKit
import RxCocoa
import RxSwift
import ReactorKit
import CommonUI

final class TopSearchHeaderCollectionViewCell: BaseCollectionViewCell, ReactorKit.View {


	// MARK: Constants
	private enum Constants {
        static let titleLabel = "인기 검색어".styled(
            typo: .Body3,
            byAdding: [.color(CommonUIAsset.grey.color)]
        )
    }

	// MARK: Propertie

	// MARK: UI Properties
    private let titleLabel = UILabel().then {
        $0.attributedText = Constants.titleLabel
    }

	// MARK: Initializing

	override func prepareForReuse() {
		super.prepareForReuse()
	}
	
	func configure(reactor: TopSearchHeaderCellReactor) {
		super.configure()
		self.reactor = reactor
	}


	// MARK: UI
	override func configureUI() {
		super.configureUI()
        self.addSubview(self.titleLabel)
	}

	// MARK: Constraints
	override func setupConstraints() {
		super.setupConstraints()
        self.titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.leading.equalToSuperview().offset(-5)
            $0.bottom.equalToSuperview().inset(10)
        }
	}

	// MARK: ReactorBind
	func bind(reactor: TopSearchHeaderCellReactor) {}

}
