//
//  CategoryViewController.swift
//  Search
//
//  Created mincheol on 2023/03/17.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit

import SnapKit
import Then
import ReactorKit
import RxCocoa
import RxSwift
import CommonUI
import RxDataSources
import ReusableKit
import Util

final class CategoryViewController: BaseViewController, ReactorKit.View {
    typealias Reactor = CategoryReactor
    typealias Category = RxCollectionViewSectionedAnimatedDataSource<CategorySection>
    // MARK: Constants
    private enum Constants { }
    
    enum Reusable {
        static let tagCell = ReusableView<CategoryTagCollectionViewCell>()
        static let tagItemCell = ReusableCell<CategoryTagItemCollectionViewCell>()
        static let categoryCell = ReusableView<CategoryHeaderCollectionViewCell>()
        static let categoryItemCell = ReusableCell<CategoryItemCollectionViewCell>()
    }
    
    // MARK: Properties
    private lazy var dataSource = self.createDataSource()
    private lazy var compositionalLayout = self.createCompositionalLayout().then {
        $0.register(CategorySectionBackgroundView.self, forDecorationViewOfKind: "background")
    }
    
    // MARK: UI Properties
    private let serachTopBar = SerachTopBar()
    private lazy var collectionView: UICollectionView = .init(
        frame: .zero,
        collectionViewLayout: self.compositionalLayout
    ).then {
        $0.backgroundColor = .white
        $0.register(Reusable.tagCell, kind: .header)
        $0.register(Reusable.tagItemCell)
        $0.register(Reusable.categoryCell, kind: .header)
        $0.register(Reusable.categoryItemCell)
    }
    // MARK: Initializing
    init(reactor: Reactor) {
        defer {
            self.reactor = reactor
        }
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationTopBar.isHidden = true
        self.reactor?.action.onNext(.viewDidLoad)
        
    }
    
    override func configureUI() {
        super.configureUI()
        self.view.backgroundColor = CommonUIAsset.pointColor.color
        self.navigationTopBar.backgroundColor = CommonUIAsset.pointColor.color
        self.view.addSubview(self.serachTopBar)
        self.view.addSubview(self.collectionView)
    }
    
    // MARK: Constraints
    override func setupConstraints() {
        super.setupConstraints()
        self.serachTopBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        self.collectionView.snp.makeConstraints {
            $0.top.equalTo(self.serachTopBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: ReactorBind
extension CategoryViewController {
    func bind(reactor: Reactor) {
        self.bindState(sections: reactor)
    }
}

// MARK: Action
extension CategoryViewController {}

// MARK: State
extension CategoryViewController {
    private func bindState(sections reactor: Reactor) {
        reactor.state.map { $0.sections }
            .asDriver(onErrorJustReturn: [])
            .drive(self.collectionView.rx.items(dataSource: self.dataSource))
            .disposed(by: self.disposeBag)
    }
}

// MARK: Func

extension CategoryViewController {
    public static func create() -> CategoryViewController {
        let reactor: CategoryReactor = .init()
        let viewController = CategoryViewController.init(reactor: reactor)
        
        return viewController
    }
    
    fileprivate func createDataSource() -> Category {
        return .init(
            configureCell: {  _, collectionView, indexPath, sectionItem in
                switch sectionItem {
                case .tagItem(let reactor):
                    return collectionView.dequeue(Reusable.tagItemCell, for: indexPath).then { cell in
                        if cell.reactor !== reactor {
                            cell.configure(reactor: reactor)
                            cell.rx.itemSelected.asDriver()
                                .throttle(.milliseconds(300))
                                .drive(onNext: { [weak self]  in
                                    guard let self = self,
                                          let reactor = self.reactor else { return }
                                    reactor.action.onNext(.didTapTagItem($0))
                                })
                                .disposed(by: cell.disposeBag)
                        }
                    }
                case .categoryItem(let reactor):
                    return collectionView.dequeue(Reusable.categoryItemCell, for: indexPath).then { cell in
                        if cell.reactor !== reactor {
                            cell.configure(reactor: reactor)
                            cell.rx.itemSelected.asDriver()
                                .throttle(.milliseconds(300))
                                .drive(onNext: { [weak self] _ in
                                    guard let self = self,
                                          let reactor = self.reactor else { return }
                                    reactor.action.onNext(.didTapCategoryItem)
                                })
                                .disposed(by: cell.disposeBag)
                        }
                    }
                }
            },
            configureSupplementaryView: { [weak self] dataSource, collectionView, _, indexPath in
                let section = dataSource[indexPath.section]
                
                switch section.identity {
                case .tag(let reactor):
                    return collectionView.dequeue(Reusable.tagCell, kind: .header, for: indexPath).then { cell in
                        if cell.reactor !== reactor {
                            cell.configure(reactor: reactor)
                        }
                    }
                case .category(let reactor):
                    return collectionView.dequeue(Reusable.categoryCell, kind: .header ,for: indexPath).then { cell in
                        if cell.reactor !== reactor {
                            cell.configure(reactor: reactor)
                            cell.rx.toggleExpand.asDriver()
                                .throttle(.milliseconds(300))
                                .drive(onNext: { [weak self] _ in
                                    guard let self = self,
                                          let reactor = self.reactor else { return }
                                    reactor.action.onNext(.didTapCategorySection)
                                })
                                .disposed(by: cell.disposeBag)
                        }
                    }
                }
            }
        )
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex:Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .estimated(60),
                heightDimension: .absolute(36)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(60)
            )
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )
            
            group.interItemSpacing = .fixed(12)
            group.edgeSpacing = .init(leading: nil, top: .fixed(8), trailing: nil, bottom: nil)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 0, leading: 12, bottom: 0, trailing: 12)
            section.supplementariesFollowContentInsets = false
            let config = UICollectionViewCompositionalLayoutConfiguration()
            config.scrollDirection = .vertical
            let layout = UICollectionViewCompositionalLayout(section: section)
            layout.configuration = config
            // Header
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(52)
            )
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            // Background
            let sectionBackgroundDecoration = NSCollectionLayoutDecorationItem.background(elementKind: "background")
            
            section.decorationItems = [sectionBackgroundDecoration]
            section.boundarySupplementaryItems = [header]
           
            return section
        }
    }
    
    private func bindDidTapSearchButton() {
        self.serachTopBar.rx.searchButtonDidTap
            .asDriver()
            .drive(with: self, onNext: { _,_  in
                print("serachTopBar")
            })
            .disposed(by: self.disposeBag)
    }
    
    private func bindDidTapBackButton() {
        self.serachTopBar.rx.backButtonDidTap
            .asDriver()
            .drive(with: self, onNext: { _,_  in
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: self.disposeBag)
    }
}
