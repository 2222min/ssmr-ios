//
//  CategoryHeaderCollectionViewCell.swift
//  Search
//
//  Created mincheol on 2023/03/19.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit

import Then
import SnapKit
import RxCocoa
import RxSwift
import ReactorKit
import CommonUI

final class CategoryHeaderCollectionViewCell: BaseCollectionViewCell, ReactorKit.View {

	typealias Reactor = CategoryHeaderCellReactor

	// MARK: Constants
	private enum Constants { }

	// MARK: Propertie

	// MARK: UI Properties
    fileprivate let categoryButton: UIButton = UIButton().then {
        $0.tintColor = .black
        $0.semanticContentAttribute = .forceRightToLeft
        $0.contentHorizontalAlignment = .trailing
        $0.titleEdgeInsets = .init(top: 14, left: 16, bottom: 14, right: 0)
        $0.imageEdgeInsets = .init(top: 12, left: 16 , bottom: 12, right: 0)
    }
    
	// MARK: Initializing

    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }
    
	func configure(reactor: Reactor) {
		super.configure()
        self.contentView.backgroundColor = .white
		self.reactor = reactor
	}


	// MARK: UI
	override func configureUI() {
		super.configureUI()
        self.addSubview(self.categoryButton)
	}

	// MARK: Constraints
	override func setupConstraints() {
		super.setupConstraints()
        self.categoryButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(52)
        }
	}

	// MARK: ReactorBind
	func bind(reactor: Reactor) {
        self.bindAction(didTapCategoryButton: reactor)
        
        reactor.state.map { $0.name }
            .asDriver(onErrorDriveWith: .empty())
            .map { $0.styled(typo: .DDaengH3)}
            .drive(self.categoryButton.rx.attributedTitle())
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.isExpand }
            .asDriver(onErrorJustReturn: false)
            .map { $0 ? CommonUIAsset.upperArrow.image : CommonUIAsset.downArrow.image }
            .map { $0.withRenderingMode(.alwaysTemplate) }
            .drive(self.categoryButton.rx.image())
            .disposed(by: self.disposeBag)
    }
}

extension CategoryHeaderCollectionViewCell {
    private func bindAction(didTapCategoryButton reactor: Reactor) {
        self.categoryButton.rx.tap.asDriver()
            .map { Reactor.Action.didTapCategoryButton }
            .drive(reactor.action)
            .disposed(by: self.disposeBag)
    }
}

extension Reactive where Base: CategoryHeaderCollectionViewCell {
  
  var toggleExpand: ControlEvent<Bool> {
    let source = self.base.categoryButton.rx.tap
      .compactMap { [weak base] _ in
        base?.reactor?.currentState.isExpand
      }
    return ControlEvent(events: source)
  }
}
