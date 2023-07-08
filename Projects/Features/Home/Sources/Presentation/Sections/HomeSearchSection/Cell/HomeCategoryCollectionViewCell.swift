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

final class HomeCategoryCollectionViewCell: BaseCollectionViewCell, ReactorKit.View {

	// MARK: Constants
	private enum Constants { }

	// MARK: Propertie

	// MARK: UI Properties
    private let container: UIButton = UIButton()
    private let imageView: UIImageView = UIImageView()
    private let categoryLabel: UILabel = UILabel()

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
        self.addSubview(self.categoryLabel)
        
        self.container.addSubview(self.imageView)
	}

	// MARK: Constraints
	override func setupConstraints() {
		super.setupConstraints()
        self.container.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(self.categoryLabel.snp.top).offset(-8)
        }
        self.imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.categoryLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(16)
        }
	}

	// MARK: ReactorBind
	func bind(reactor: HomeHashTagCellReactor) {
        self.bindState(hasgTag: reactor)
        self.bindState(image: reactor)
    }

}

extension HomeCategoryCollectionViewCell {
    private func bindState(hasgTag reactor: HomeHashTagCellReactor) {
        reactor.state.map { $0.hashTag }
            .asDriver(onErrorDriveWith: .empty())
            .map { $0.styled(
                typo: .Body3,
                byAdding: [.color(CommonUIAsset.black.color)]
            )}
            .drive(self.categoryLabel.rx.attributedText)
            .disposed(by: self.disposeBag)
    }
    private func bindState(image reactor: HomeHashTagCellReactor) {
        reactor.state.map { $0.image }
            .asDriver(onErrorDriveWith: .empty())
            .drive(self.imageView.rx.image)
            .disposed(by: self.disposeBag)
    }
}
