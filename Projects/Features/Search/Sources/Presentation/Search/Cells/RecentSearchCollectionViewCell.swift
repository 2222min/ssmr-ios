//
//  RecentSearchCollectionViewCell.swift
//  Search
//
//  Created mincheol on 2023/04/11.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit

import Then
import SnapKit
import RxCocoa
import RxSwift
import ReactorKit
import CommonUI
import Util

final class RecentSearchCollectionViewCell: BaseCollectionViewCell, ReactorKit.View {

	typealias Reactor = RecentSearchCellReactor

	// MARK: Constants
	private enum Constants { }

	// MARK: Propertie

	// MARK: UI Properties
    private let button: UIButton = UIButton()
    private let wordLabel: UILabel = UILabel()
    private let removeImageView: UIImageView = UIImageView().then {
        $0.image = CommonUIAsset.tagClose.image
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
        self.addSubview(self.button)
        self.button.addSubview(self.wordLabel)
        self.button.addSubview(self.removeImageView)
	}

	// MARK: Constraints
	override func setupConstraints() {
		super.setupConstraints()
        self.button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.wordLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        self.removeImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(16)
        }
	}

	// MARK: ReactorBind
	func bind(reactor: Reactor) {
        self.bindState(recentWord: reactor)
    }

}

extension RecentSearchCollectionViewCell {
    private func bindState(recentWord reactor: Reactor) {
        reactor.state.map { $0.recentWord }
            .distinctUntilChanged()
            .asDriver(onErrorDriveWith: .empty())
            .map { $0.styled(
                typo: .DDaengMB3_Regular,
                byAdding: [.color(CommonUIAsset.black.color)])
            }
            .drive(self.wordLabel.rx.attributedText)
            .disposed(by: self.disposeBag)
    }
}
