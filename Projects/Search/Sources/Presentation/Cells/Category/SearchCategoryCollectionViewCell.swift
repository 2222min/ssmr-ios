//
//  SearchCategoryCollectionViewCell.swift
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

final class SearchCategoryCollectionViewCell: BaseCollectionViewCell, ReactorKit.View {

	typealias Reactor = SearchCategoryCellReactor

	// MARK: Constants
	private enum Constants { }

	// MARK: Propertie

	// MARK: UI Properties
    fileprivate let categoryButton = UIButton()
    private let nameLabel = UILabel()
	// MARK: Initializing

    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }
    
	func configure(reactor: Reactor) {
		super.configure()
		self.reactor = reactor
	}


	// MARK: UI
	override func configureUI() {
		super.configureUI()
        self.addSubview(self.categoryButton)
        self.categoryButton.addSubview(self.nameLabel)
	}

	// MARK: Constraints
	override func setupConstraints() {
		super.setupConstraints()
        self.categoryButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(52)
        }
        self.nameLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().offset(16)
        }
	}

	// MARK: ReactorBind
	func bind(reactor: Reactor) {
        self.bindAction(didTapCategoryButton: reactor)
        
        reactor.state.map { $0.name }
            .asDriver(onErrorDriveWith: .empty())
            .map { $0.styled(typo: .DDaengH3)}
            .drive(self.nameLabel.rx.attributedText)
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.isExpand }
            .asDriver(onErrorJustReturn: false)
            .map { $0 ? CommonUIAsset.upperArrow.image : CommonUIAsset.downArrow.image }
            .map { $0.withRenderingMode(.alwaysTemplate) }
            .drive(self.categoryButton.rx.image())
            .disposed(by: self.disposeBag)
    }
    
    // MARK: CellSize
    static func size(width: CGFloat) -> CGSize {
        let height: CGFloat = 52
        return CGSize(width: width, height: height)
    }
}

extension SearchCategoryCollectionViewCell {
    private func bindAction(didTapCategoryButton reactor: Reactor) {
        self.categoryButton.rx.tap.asDriver()
            .map { Reactor.Action.didTapCategoryButton }
            .drive(reactor.action)
            .disposed(by: self.disposeBag)
    }
}

extension Reactive where Base: SearchCategoryCollectionViewCell {
  
  var toggleExpand: ControlEvent<Bool> {
    let source = self.base.categoryButton.rx.tap
      .compactMap { [weak base] _ in
        base?.reactor?.currentState.isExpand
      }
    return ControlEvent(events: source)
  }
}
