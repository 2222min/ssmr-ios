//
//  HomeSearchViewController.swift
//  HomePresentation
//
//  Created by 정건호 on 2023/04/24.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit
import CommonUI
import ReusableKit
import RxDataSources

class HomeSearchViewController: BaseViewController {
    
    typealias HashTag = RxCollectionViewSectionedReloadDataSource<HomeHashTagSection>
    
    // MARK: Reusable
    private enum Reusable {
        static let hashTagCell = ReusableCell<HomeHashTagCollectionViewCell>()
    }
  
    // MARK: Properties
    
    private lazy var dataSource = self.createDataSource()
    
    private let container = UIView().then {
        $0.backgroundColor = .white
    }
    
    // MARK: UI Properties
    
    private let titleLabel: UILabel = UILabel()
    private let alarmButton: UIButton = UIButton().then {
        $0.setImage(CommonUIAsset.homeBell.image, for: .normal)
    }
    private let searchButton: SerachButton = .init().then {
        $0.placeholder = "오늘의 핫플을 검색해주세요"
    }
    private lazy var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: self.createCompositionalLayout()
    ).then {
        $0.register(Reusable.hashTagCell)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    override func configureUI() {
        self.view.addSubview(self.container)
        
        [
            titleLabel, alarmButton,
            searchButton, collectionView
        ].forEach {
            self.container.addSubview($0)
        }
        
        self.setupConstraints()
    }
    
    override func setupConstraints() {
        self.container.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        self.titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(28)
            $0.leading.equalToSuperview().offset(16)
        }
        self.alarmButton.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.top)
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(24)
        }
        self.searchButton.snp.makeConstraints {
            $0.top.equalTo(self.alarmButton.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        self.collectionView.snp.makeConstraints {
            $0.top.equalTo(self.searchButton.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(32)
            $0.height.equalTo(28)
        }
    }
    
    
}

extension HomeSearchViewController {
    fileprivate func createDataSource() -> HashTag {
        return .init(
            configureCell: {  _, collectionView, indexPath, sectionItem in
                switch sectionItem {
                case let .hashTagItem(reactor) :
                    return collectionView.dequeue(Reusable.hashTagCell, for: indexPath).then { cell in
                        if cell.reactor !== reactor {
                            cell.configure(reactor: reactor)
                        }
                    }
                }
            }
        )
    }
}

extension HomeSearchViewController {
     func createCompositionalLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex:Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(32)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(32)
            )
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )
            let section = NSCollectionLayoutSection(group: group)
            let config = UICollectionViewCompositionalLayoutConfiguration()
            config.scrollDirection = .vertical
            let layout = UICollectionViewCompositionalLayout(section: section)
            layout.configuration = config
            // Header
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(0)
            )
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            
            section.boundarySupplementaryItems = [header]
            
            return section
        }
    }
}
