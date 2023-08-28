//
//  RecentSearchHeaderCollectionViewCell.swift
//  Search
//
//  Created mincheol on 2023/04/15.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit

import Then
import SnapKit
import RxCocoa
import RxSwift
import ReactorKit
import CommonUI

final class RecentSearchHeaderCollectionViewCell: BaseCollectionViewCell, ReactorKit.View {

	typealias Reactor = RecentSearchHeaderCellReactor

	// MARK: Constants
	private enum Constants { }

	// MARK: Propertie

	// MARK: UI Properties
    private let container: UIView = UIView()
    private let titleLabel: UILabel = UILabel().then {
        $0.attributedText = "최근 검색어".styled(
            typo: CoreTypo.Body2_B,
            byAdding: [.color(CommonUIAsset.deepGrey.color)]
        )
    }
    private let deleteButton: UIButton = UIButton().then {
        $0.setAttributedTitle(
            "전체삭제".styled(
            typo: CoreTypo.Body3,
            byAdding: [.color(CommonUIAsset.grey.color)]
            ), for: .normal
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
        self.addSubview(self.container)
        self.container.addSubview(self.titleLabel)
        self.container.addSubview(self.deleteButton)
	}

	// MARK: Constraints
	override func setupConstraints() {
		super.setupConstraints()
        self.container.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(40)
        }
        self.titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        self.deleteButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
	}

	// MARK: ReactorBind
	func bind(reactor: Reactor) {
        self.bindState(isHidden: reactor)
    }
}

extension RecentSearchHeaderCollectionViewCell {
    private func bindState(isHidden reactor: Reactor) {
        reactor.state.map { $0.isHidden }
            .distinctUntilChanged()
            .asDriver(onErrorDriveWith: .empty())
            .drive(with: self, onNext: { _, isHidden in
                self.container.isHidden = isHidden
                self.container.snp.updateConstraints {
                    $0.height.equalTo(isHidden ? 0 : 40)
                }
            })
            .disposed(by: self.disposeBag)
    }
}
