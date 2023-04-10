//
//  CategoryTagItemCollectionViewCell.swift
//  Search
//
//  Created mincheol on 2023/04/02.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit

import Then
import SnapKit
import RxCocoa
import RxSwift
import ReactorKit
import CommonUI


final class CategoryTagItemCollectionViewCell: BaseCollectionViewCell, ReactorKit.View {
    
    typealias Reactor = CategoryTagItemCellReactor
    
    // MARK: Constants
    private enum Constants { }
    
    // MARK: Propertie
    
    // MARK: UI Properties
    private let button: UIButton = UIButton().then {
        $0.backgroundColor = CommonUIAsset.mOrange.color
        $0.layer.cornerRadius = 8
    }
    private let nameLabel: UILabel = UILabel()
    private let imageView: UIImageView = UIImageView().then {
        $0.image = CommonUIAsset.searchClose.image
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
        [
            self.nameLabel,
            self.imageView
        ]
            .forEach {
                self.button.addSubview($0)
            }
        self.addSubview(self.button)
    }
    
    // MARK: Constraints
    override func setupConstraints() {
        super.setupConstraints()
        self.button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.nameLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().offset(20)
        }
        self.imageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(self.nameLabel.snp.trailing).offset(8)
            $0.size.equalTo(16)
        }
    }
    
    // MARK: ReactorBind
    func bind(reactor: Reactor) {
        self.bindState(name: reactor)
    }
    
}

// MARK: State

extension CategoryTagItemCollectionViewCell {
    private func bindState(name reactor: Reactor) {
        reactor.state.map { $0.name }
            .distinctUntilChanged()
            .asDriver(onErrorDriveWith: .empty())
            .map { $0.styled(
                typo: .DDaenMB3_Bold,
                byAdding: [.color(CommonUIAsset.deepGrey.color)]
            )
            }
            .drive(self.nameLabel.rx.attributedText)
            .disposed(by: self.disposeBag)
    }
}
