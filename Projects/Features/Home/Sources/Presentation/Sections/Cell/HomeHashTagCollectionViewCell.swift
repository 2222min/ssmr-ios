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
	}

	// MARK: Constraints
	override func setupConstraints() {
		super.setupConstraints()
	}

	// MARK: ReactorBind
	func bind(reactor: HomeHashTagCellReactor) {}

}
