//
//  OnboardingCollectionViewCell.swift
//  Onboarding
//
//  Created mincheol on 2022/09/16.
//  Copyright © 2022 team.io. All rights reserved.
//

import CommonUI

import UIKit
import Then
import SnapKit
import RxCocoa
import RxSwift
import ReactorKit


final class OnboardingCollectionViewCell: BaseCollectionViewCell {
	typealias Reactor = OnboardingCellReactor

	// MARK: Constants
	private enum Constants { }

	// MARK: Propertie

	// MARK: UI Properties
    private let dotImageView = UIImageView().then {
        $0.image = CommonUIAsset.dotImage8.image
    }
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }

	// MARK: Initializing

	override func prepareForReuse() {
		super.prepareForReuse()
	}
	
    func configure(item: OnboardingModel) {
		super.configure()
        self.setUIProperties(item)
	}


	// MARK: UI
	override func configureUI() {
		super.configureUI()
        
        [
            self.titleLabel,
            self.dotImageView,
            self.descriptionLabel,
            self.imageView
        ]
            .forEach(self.contentView.addSubview)
	}

	// MARK: Constraints
	override func setupConstraints() {
		super.setupConstraints()
        self.titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(96)
            $0.centerX.equalToSuperview()
        }
        self.dotImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.top).offset(32)
            $0.left.equalTo(titleLabel.snp.right).offset(6)
        }
        self.descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(16)
            $0.height.equalTo(19)
            $0.centerX.equalToSuperview()
        }
        self.imageView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(22)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(319)
        }
	}

	// MARK: ReactorBind
	func bind(reactor: Reactor) {}

}

extension OnboardingCollectionViewCell {
    private func setUIProperties(_ item: OnboardingModel) {
        self.titleLabel.attributedText = item.title.styled(
            typo: .Display,
            byAdding: [.color(CommonUIAsset.blackGrey.color)]
        )
        self.descriptionLabel.attributedText = item.description.styled(
            typo: .Body1,
            byAdding: [.color(CommonUIAsset.grey.color)]
        )
        self.imageView.image = item.image
    }
}
