//
//  SearchResultCollectionViewCell.swift
//  Search
//
//  Created mincheol on 2023/08/27.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit
import Then
import SnapKit
import RxCocoa
import RxSwift
import ReactorKit
import CommonUI

final class SearchResultCollectionViewCell: BaseCollectionViewCell, ReactorKit.View {


	// MARK: Constants
	private enum Constants { }

	// MARK: Propertie

	// MARK: UI Properties
    private let itemButton: UIButton = UIButton()
    private let itemImage: UIImageView = UIImageView().then {
        $0.image = CommonUIAsset.awardImage.image
    }

    private let name: UILabel = UILabel()
    private let ratingImage: UIImageView = UIImageView()
    private let rating: UILabel = UILabel()

	// MARK: Initializing

	override func prepareForReuse() {
		super.prepareForReuse()
	}
	
	func configure(reactor: SearchResultCellReactor) {
		super.configure()
		self.reactor = reactor
	}


	// MARK: UI
	override func configureUI() {
		super.configureUI()
        [
            self.itemImage,
            self.name,
            self.ratingImage,
            self.rating
        ]
            .forEach(self.itemButton.addSubview)
        
        self.addSubview(self.itemButton)
	}

	// MARK: Constraints
	override func setupConstraints() {
		super.setupConstraints()
        self.itemButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.itemImage.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(151)
        }
        self.name.snp.makeConstraints {
            $0.top.equalTo(self.itemImage.snp.bottom).offset(8)
            $0.leading.equalToSuperview()
        }
        self.ratingImage.snp.makeConstraints {
            $0.top.equalTo(self.itemImage.snp.bottom).offset(8)
            $0.leading.equalTo(self.name.snp.trailing).offset(5)
            $0.size.equalTo(19)
        }
        self.rating.snp.makeConstraints {
            $0.top.equalTo(self.itemImage.snp.bottom).offset(11)
            $0.leading.equalTo(self.ratingImage.snp.trailing).offset(4)
        }
	}

	// MARK: ReactorBind
	func bind(reactor: SearchResultCellReactor) {}

}
