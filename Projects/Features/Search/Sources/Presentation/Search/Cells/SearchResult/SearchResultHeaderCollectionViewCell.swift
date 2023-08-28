//
//  SearchResultHeaderCollectionViewCell.swift
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


final class SearchResultHeaderCollectionViewCell: BaseCollectionViewCell, ReactorKit.View {


	// MARK: Constants
	private enum Constants {
        static let placeButtonTitle = "땡플레이스".styled(
            typo: .Body3_B,
            byAdding: [.color(CommonUIAsset.grey.color)]
        )
        static let placeButtonSelectedTitle = "땡플레이스".styled(
            typo: .Body3_B,
            byAdding: [.color(CommonUIAsset.pointColor.color)]
        )
        static let courceButtonTitle = "코스추천".styled(
            typo: .Body3_B,
            byAdding: [.color(CommonUIAsset.grey.color)]
        )
        static let courceButtonSelectedTitle = "코스추천".styled(
            typo: .Body3_B,
            byAdding: [.color(CommonUIAsset.pointColor.color)]
        )
    }

	// MARK: Propertie

	// MARK: UI Properties
    private let stackView: UIStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
    }
    let placeButton: UIButton = UIButton().then {
        $0.setAttributedTitle(Constants.placeButtonTitle, for: .normal)
        $0.setAttributedTitle(Constants.placeButtonSelectedTitle, for: .selected)
    }
    let courseRecommendationButton: UIButton = UIButton().then {
        $0.setAttributedTitle(Constants.courceButtonTitle, for: .normal)
        $0.setAttributedTitle(Constants.courceButtonSelectedTitle, for: .selected)
    }
    
	// MARK: Initializing

	override func prepareForReuse() {
		super.prepareForReuse()
	}
	
	func configure(reactor: SearchResultHeaderCellReactor) {
		super.configure()
		self.reactor = reactor
	}


	// MARK: UI
	override func configureUI() {
		super.configureUI()
        [
            self.placeButton,
            self.courseRecommendationButton
        ].forEach(self.stackView.addArrangedSubview)
        
        self.addSubview(self.stackView)
	}

	// MARK: Constraints
	override func setupConstraints() {
		super.setupConstraints()
        self.stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(52)
        }
	}

	// MARK: ReactorBind
	func bind(reactor: SearchResultHeaderCellReactor) {}
}
