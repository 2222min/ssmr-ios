//
//  CategoryTagCollectionViewCell.swift
//  Search
//
//  Created mincheol on 2023/04/02.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit

import Then
import SnapKit
import RxCocoa
import RxSwift
import ReactorKit
import CommonUI

final class CategoryTagCollectionViewCell: BaseCollectionViewCell, ReactorKit.View {

	typealias Reactor = CategoryTagCellReactor

	// MARK: Constants
	private enum Constants { }

	// MARK: Propertie

	// MARK: UI Properties
    private let label: UILabel = UILabel().then {
        $0.attributedText = "테마별 카테고리".styled(
            typo: .DDaengH3,
            byAdding: [.color(CommonUIAsset.pointColor.color)]
        )
    }
    private let confirmButton: UIButton = UIButton().then {
        $0.setAttributedTitle(
            "완료".styled(
                typo: .DDaengMB3_Bold,
                byAdding: [.color(CommonUIAsset.deepGrey.color)]
            ),
            for: .normal
        )
    }
	// MARK: Initializing

	override func prepareForReuse() {
		super.prepareForReuse()
	}
	
	func configure(reactor: Reactor) {
		super.configure()
		self.reactor = reactor
	}


	// MARK: UI
	override func configureUI() {
		super.configureUI()
        [
            self.label,
            self.confirmButton
        ]
            .forEach {
                self.addSubview($0)
            }
	}

	// MARK: Constraints
	override func setupConstraints() {
		super.setupConstraints()
        self.label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        self.confirmButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(16)
        }
	}

	// MARK: ReactorBind
	func bind(reactor: Reactor) {}

}
