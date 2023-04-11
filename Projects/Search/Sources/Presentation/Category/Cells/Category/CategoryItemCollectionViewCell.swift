//
//  CategoryItemCollectionViewCell.swift
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

final class CategoryItemCollectionViewCell: BaseCollectionViewCell, ReactorKit.View {

    typealias Reactor = CategoryItemCellReactor

    // MARK: Constants
    private enum Constants { }

    // MARK: Propertie

    // MARK: UI Properties
    fileprivate let nameButton = UIButton().then {
        $0.backgroundColor = .white
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
        self.bindState(isSelected: reactor)
        // Action
        self.bindAction(didTapCategoryButton: reactor)
    }
}

// MARK: State

extension CategoryItemCollectionViewCell {
    private func bindState(name reactor: Reactor) {
        reactor.state.map { $0.name }
            .asDriver(onErrorDriveWith: .empty())
            .map { $0.styled(typo: CoreTypo.DDaengMB3_Bold)}
            .drive { self.nameButton.setAttributedTitle($0, for: .normal) }
            .disposed(by: self.disposeBag)
    }
    private func bindState(isSelected reactor: Reactor) {
        reactor.state.map { $0.isSelected }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
            .map { $0 ?  CommonUIAsset.mOrange.color :  CommonUIAsset.white.color}
            .drive { self.nameButton.setBackgroundColor(color: $0, forState: .normal) }
            .disposed(by: self.disposeBag)
    }
}

// MARK: Action

extension CategoryItemCollectionViewCell {
    private func bindAction(didTapCategoryButton reactor: Reactor) {
        self.nameButton.rx.tap.asDriver()
            .map { Reactor.Action.didTapNameButton }
            .drive(reactor.action)
            .disposed(by: self.disposeBag)
    }
}

extension Reactive where Base: CategoryItemCollectionViewCell {
  
  var itemSelected: ControlEvent<Bool> {
    let source = self.base.nameButton.rx.tap
      .compactMap { [weak base] _ in
          base?.reactor?.currentState.isSelected
      }
    return ControlEvent(events: source)
  }
}
