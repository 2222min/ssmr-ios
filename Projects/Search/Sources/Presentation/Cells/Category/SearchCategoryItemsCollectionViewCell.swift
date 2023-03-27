//
//  SearchCategoryItemsCollectionViewCell.swift
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
import ReusableKit
import RxDataSources

final class SearchCategoryItemsCollectionViewCell: BaseCollectionViewCell, ReactorKit.View {

	typealias Reactor = SearchCategoryItemsCellReactor
    
	// MARK: Constants
	private enum Constants { }

    enum Reusable {
      static let itemCell = ReusableCell<SearchCategoryItemCollectionViewCell>()
    }
    
	// MARK: Propertie
    private lazy var compositionalLayout = self.createCompositionalLayout()
	// MARK: UI Properties
    private lazy var collectionView: UICollectionView = .init(
        frame: .zero,
        collectionViewLayout: self.compositionalLayout
    ).then {
        $0.register(Reusable.itemCell)
        $0.backgroundColor = CommonUIAsset.cream.color
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
        self.addSubview(self.collectionView)
	}

	// MARK: Constraints
	override func setupConstraints() {
		super.setupConstraints()
        self.collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
	}

	// MARK: ReactorBind
	func bind(reactor: Reactor) {
        // State
        self.bindState(cellReactor: reactor)
    }
    
    // MARK: CellSize
    static func size(
        width: CGFloat,
        cellReactor: Reactor
    ) -> CGSize {
        let totalWidth = UIScreen.main.bounds.width - 32
        let itemWidthArr: [CGFloat] = cellReactor.currentState.cellReactor.map {
            let label = UILabel(frame: CGRect.zero)
            label.attributedText = $0.currentState.name.styled(typo: .DDaenMB3_Bold)
            label.sizeToFit()
            let itemWidth = label.frame.width + 40
            return itemWidth
        }
        var line = 1
        var temp: CGFloat = 0
        itemWidthArr.forEach { item in
            if temp + item + 12 >= totalWidth {
                temp = item + 12
                line += 1
            } else {
                temp = temp + item + 12
            }
        }
        
        let height: CGFloat = line > 1 ? CGFloat((36 * line) + (12 * (line - 1))) : 36
        
        return CGSize(width: width, height: height + 24)
    }
}

extension SearchCategoryItemsCollectionViewCell {
    private func bindState(cellReactor reactor: Reactor) {
        reactor.state.map { $0.cellReactor }
            .asDriver(onErrorDriveWith: .empty())
            .drive(self.collectionView.rx.items(
                cellIdentifier: Reusable.itemCell.identifier,
                cellType: Reusable.itemCell.class)) { _, item, cell in
                    cell.configure(reactor: item)
                }
                .disposed(by: self.disposeBag)                                                         
    }
}

extension SearchCategoryItemsCollectionViewCell {
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
                   widthDimension: .estimated(60),
                   heightDimension: .absolute(38)
               )

               let item = NSCollectionLayoutItem(layoutSize: itemSize)

               let groupSize = NSCollectionLayoutSize(
                   widthDimension: .fractionalWidth(1.0),
                   heightDimension: .absolute(38)
               )

               let group = NSCollectionLayoutGroup.horizontal(
                   layoutSize: groupSize,
                   subitems: [item]
               )
               group.interItemSpacing = .fixed(12)

               let section = NSCollectionLayoutSection(group: group)
               section.interGroupSpacing = 12
               section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)

               let config = UICollectionViewCompositionalLayoutConfiguration()
               config.scrollDirection = .vertical

               let layout = UICollectionViewCompositionalLayout(section: section)
               layout.configuration = config
               return layout
           }
}
