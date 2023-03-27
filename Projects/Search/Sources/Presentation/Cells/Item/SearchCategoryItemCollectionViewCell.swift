//
//  SearchCategoryItemCollectionViewCell.swift
//  Search
//
//  Created mincheol on 2023/03/25.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit

import Then
import SnapKit
import RxCocoa
import RxSwift
import ReactorKit
import CommonUI

final class SearchCategoryItemCollectionViewCell: BaseCollectionViewCell, ReactorKit.View {

	typealias Reactor = SearchCategoryItemCellReactor

	// MARK: Constants
	private enum Constants { }

	// MARK: Propertie

	// MARK: UI Properties
    private let nameButton = UIButton().then {
        $0.contentEdgeInsets = .init(top: 10, left: 20, bottom: 10, right: 20)
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
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        self.addSubview(self.nameButton)
	}

	// MARK: Constraints
	override func setupConstraints() {
		super.setupConstraints()
        self.nameButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
	}

	// MARK: ReactorBind
    func bind(reactor: Reactor) {
        // State
        self.bindState(name: reactor)
    }
}

// MARK: State

extension SearchCategoryItemCollectionViewCell {
    private func bindState(name reactor: Reactor) {
        reactor.state.map { $0.name }
            .asDriver(onErrorDriveWith: .empty())
            .map { $0.styled(typo: CoreTypo.DDaenMB3_Bold)}
            .drive { self.nameButton.setAttributedTitle($0, for: .normal) }
            .disposed(by: self.disposeBag)
    }
}
