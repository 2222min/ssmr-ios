//
//  TopSearchCollectionViewCell.swift
//  Search
//
//  Created by mincheol on 2023/08/20.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit
import Then
import SnapKit
import RxCocoa
import RxSwift
import ReactorKit
import CommonUI

final class TopSearchCollectionViewCell: BaseCollectionViewCell, ReactorKit.View {

    typealias Reactor = TopSearchCollectionViewCellReactor

    // MARK: Constants
    private enum Constants { }

    // MARK: Propertie

    // MARK: UI Properties
    private let tagButton: UIButton = UIButton().then {
        $0.layer.cornerRadius = 18
        $0.layer.borderWidth = 1
        $0.layer.borderColor = CommonUIAsset.whiteGrey.color.cgColor
    }
    private let tagLabel: UILabel = UILabel()
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
        self.addSubview(self.tagButton)
        self.tagButton.addSubview(self.tagLabel)
    }

    // MARK: Constraints
    override func setupConstraints() {
        super.setupConstraints()
        self.tagButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(32)
        }
        self.tagLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.center.equalToSuperview()
        }
    }

    // MARK: ReactorBind
    func bind(reactor: Reactor) {
        self.bindState(topSearchItem: reactor)
    }
}

extension TopSearchCollectionViewCell {
    private func bindState(topSearchItem reactor: Reactor) {
        reactor.state.map { $0.topSearchItem }
            .distinctUntilChanged()
            .asDriver(onErrorDriveWith: .empty())
            .map { ("# " + $0).styled(
                typo: .Body3,
                byAdding: [.color(CommonUIAsset.black.color)]
            )}
            .drive(tagLabel.rx.attributedText)
            .disposed(by: self.disposeBag)
    }
}
