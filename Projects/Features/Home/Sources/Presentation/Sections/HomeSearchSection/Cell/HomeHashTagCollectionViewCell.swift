//
//  HomeHashTagCollectionViewCell.swift
//  Home
//
//  Created mincheol on 2023/05/27.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit

import Then
import SnapKit
import RxCocoa
import RxSwift
import ReactorKit
import CommonUI

final class HomeHashTagCollectionViewCell: BaseCollectionViewCell, ReactorKit.View {

	// MARK: Constants
	private enum Constants { }

	// MARK: Propertie

	// MARK: UI Properties
    private let container: UIButton = UIButton().then {
        $0.layer.cornerRadius = 12.5
        $0.layer.borderWidth = 1.4
        $0.layer.borderColor = CommonUIAsset.cream.color.cgColor
    }
    private let hashTagLabel: UILabel = UILabel()

	// MARK: Initializing

	override func prepareForReuse() {
		super.prepareForReuse()
	}
	
	func configure(reactor: HomeHashTagCellReactor) {
		super.configure()
		self.reactor = reactor
	}


	// MARK: UI
	override func configureUI() {
		super.configureUI()
        self.addSubview(self.container)
        self.container.addSubview(self.hashTagLabel)
	}

	// MARK: Constraints
	override func setupConstraints() {
		super.setupConstraints()
        self.container.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.hashTagLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
	}

	// MARK: ReactorBind
	func bind(reactor: HomeHashTagCellReactor) {
        self.bindState(hasgTag: reactor)
    }

}

extension HomeHashTagCollectionViewCell {
    private func bindState(hasgTag reactor: HomeHashTagCellReactor) {
        reactor.state.map { $0.hashTag }
            .asDriver(onErrorDriveWith: .empty())
            .map { $0.styled(
                typo: .DDaengMB3_Regular,
                byAdding: [.color(CommonUIAsset.deepGrey.color)]
            )}
            .drive(self.hashTagLabel.rx.attributedText)
            .disposed(by: self.disposeBag)
    }
}
