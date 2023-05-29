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
    
    private enum Reusable {
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
    private let searchTopBar = SearchTopBar().then {
        $0.textFieldIsEnabled = false
    }
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
        self.view.addSubview(self.searchTopBar)
        self.view.addSubview(self.collectionView)
    }
    
    // MARK: Constraints
    override func setupConstraints() {
        super.setupConstraints()
        self.searchTopBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        self.collectionView.snp.makeConstraints {
            $0.top.equalTo(self.searchTopBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: ReactorBind
extension CategoryViewController {
    func bind(reactor: Reactor) {
        self.bindState(sections: reactor)
        self.bindDidTapBackButton()
        self.bindDidTapSearchButton()
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
    
    private func bindDidTapSearchButton() {
        self.searchTopBar.rx.searchButtonDidTap
            .asDriver()
            .drive(with: self, onNext: { _,_  in
                let vc = SearchViewController.init(reactor: .init())
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: self.disposeBag)
    }
    
    private func bindDidTapBackButton() {
        self.searchTopBar.rx.backButtonDidTap
            .asDriver()
            .drive(with: self, onNext: { _,_  in
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: self.disposeBag)
    }
}
