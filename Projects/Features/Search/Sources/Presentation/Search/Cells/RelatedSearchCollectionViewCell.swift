//
//  RelatedSearchCollectionViewCell.swift
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
import Util

final class RelatedSearchCollectionViewCell: BaseCollectionViewCell, ReactorKit.View {

	typealias Reactor = RelatedSearchCellReactor

	// MARK: Constants
	private enum Constants { }

	// MARK: Propertie

	// MARK: UI Properties
    private let wordButton: UIButton = UIButton()

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
        self.addSubview(self.wordButton)
	}

	// MARK: Constraints
	override func setupConstraints() {
		super.setupConstraints()
        self.wordButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
	}

	// MARK: ReactorBind
	func bind(reactor: Reactor) {
        self.bindState(relatedWord: reactor)
    }
}

extension RelatedSearchCollectionViewCell {
    private func bindState(relatedWord reactor: Reactor) {
        reactor.state.map { $0.relatedWord }
            .distinctUntilChanged()
            .asDriver(onErrorDriveWith: .empty())
            .map { $0.styled(
                typo: .DDaengMB3_Regular,
                byAdding: [.color(CommonUIAsset.black.color)])
            }
            .drive { self.wordButton.setAttributedTitle($0, for: .normal) }
            .disposed(by: self.disposeBag)
    }
}
