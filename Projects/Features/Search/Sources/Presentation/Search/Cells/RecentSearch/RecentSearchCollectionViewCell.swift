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
    private let wordButton: UIButton = UIButton()
    private let removeButton: UIButton = UIButton().then {
        $0.setImage(CommonUIAsset.tagClose.image, for: .normal)
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
            self.wordButton,
            self.removeButton
        ].forEach {
            self.addSubview($0)
        }
	}

	// MARK: Constraints
	override func setupConstraints() {
		super.setupConstraints()
        self.wordButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        self.removeButton.snp.makeConstraints {
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
                typo: .Body3,
                byAdding: [.color(CommonUIAsset.black.color)])
            }
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                self.wordButton.setAttributedTitle($0, for: .normal)
            })
            .disposed(by: self.disposeBag)
    }
}
