//
//  SearchViewController.swift
//  Search
//
//  Created mincheol on 2023/04/11.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit

import SnapKit
import Then
import ReactorKit
import RxCocoa
import RxSwift
import CommonUI
import Util
import ReusableKit
import RxDataSources

final class SearchViewController: BaseViewController, ReactorKit.View {
    
    typealias Reactor = SearchReactor
    typealias Search = RxCollectionViewSectionedReloadDataSource<SearchSection>
    // MARK: Reusable
    private enum Reusable {
        static let topSerachHeaderView = ReusableView<TopSearchHeaderCollectionViewCell>()
        static let topSearchCell = ReusableCell<TopSearchCollectionViewCell>()
        static let recentSearchHeaderView = ReusableView<RecentSearchHeaderCollectionViewCell>()
        static let recentSearchCell = ReusableCell<RecentSearchCollectionViewCell>()
        static let relatedSearchCell = ReusableCell<RelatedSearchCollectionViewCell>()
        static let resultSearchHeaderView = ReusableView<SearchResultHeaderCollectionViewCell>()
        static let resultSearchCell = ReusableCell<SearchResultCollectionViewCell>()
        static let optionCell = ReusableCell<SearchOptionCollectionViewCell>()
    }
    
    // MARK: Properties
    lazy var dataSource = self.createDataSource()
    // MARK: UI Properties
    private let searchTopBar = SearchTopBar().then {
        $0.deleteButtonIsHidden = false
        $0.borderColor = CommonUIAsset.pointColor.color.cgColor
        $0.borderWidth = 2
    }
    
    private let contentView: UIView = UIView()
    
    private lazy var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: self.createCompositionalLayout()
    ).then {
        $0.register(Reusable.topSerachHeaderView, kind: .header)
        $0.register(Reusable.topSearchCell)
        $0.register(Reusable.recentSearchHeaderView, kind: .header)
        $0.register(Reusable.recentSearchCell)
        $0.register(Reusable.relatedSearchCell)
        $0.register(Reusable.resultSearchHeaderView, kind: .header)
        $0.register(Reusable.resultSearchCell)
        $0.register(Reusable.optionCell)
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
    }
    
    override func configureUI() {
        super.configureUI()
        self.view.addSubview(self.searchTopBar)
        self.view.addSubview(contentView)
        self.contentView.addSubview(self.collectionView)
    }
    
    // MARK: Constraints
    override func setupConstraints() {
        super.setupConstraints()
        self.searchTopBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        self.contentView.snp.makeConstraints {
            $0.top.equalTo(self.searchTopBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        self.collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: ReactorBind
extension SearchViewController {
    func bind(reactor: Reactor) {
        // Func
        self.bindDidTapBackButton()
        // Action
        self.bindTextFieldIsEditing(show: reactor)
        // State
        self.bindState(searchView: reactor)
    }
}

// MARK: Action
extension SearchViewController {
    private func bindTextFieldIsEditing(show reactor: Reactor) {
        self.searchTopBar.rx.textFieldIsEditing
            .asDriver()
            .drive(with: self, onNext: { _, text in
                guard let text = text,
                      !text.isEmpty
                else {
                    reactor.action.onNext(.showRecentSearchView)
                    return
                }
                reactor.action.onNext(.showResultSearchView)
            })
            .disposed(by: self.disposeBag)
    }
}

// MARK: State
extension SearchViewController {
    private func bindState(searchView reactor: Reactor) {
        reactor.state.map { $0.searchView }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: [])
            .drive(self.collectionView.rx.items(dataSource: self.dataSource))
            .disposed(by: self.disposeBag)
    }
}

// MARK: Func
extension SearchViewController {
    private func bindDidTapBackButton() {
        self.searchTopBar.rx.backButtonDidTap
            .asDriver()
            .drive(with: self, onNext: { _,_  in
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: self.disposeBag)
    }
    
    fileprivate func createDataSource() -> Search {
        return .init(
            configureCell: {  dataSource, collectionView, indexPath, sectionItem in
                let section = dataSource[indexPath.section]
                
                switch sectionItem {
                case let .topSearch(reactor):
                    return collectionView.dequeue(Reusable.topSearchCell, for: indexPath).then { cell in
                        if cell.reactor !== reactor {
                            cell.configure(reactor: reactor)
                        }
                    }
                case let .recentSearch(reactor) :
                    return collectionView.dequeue(Reusable.recentSearchCell, for: indexPath).then { cell in
                        if cell.reactor !== reactor {
                            cell.configure(reactor: reactor)
                        }
                    }
                case let .relatedSearch(reactor):
                    return collectionView.dequeue(Reusable.relatedSearchCell, for: indexPath).then { cell in
                        if cell.reactor !== reactor {
                            cell.configure(reactor: reactor)
                        }
                    }
                case let .resultItem(reactor):
                    return collectionView.dequeue(Reusable.resultSearchCell, for: indexPath).then { cell in
                        if cell.reactor !== reactor {
                            cell.configure(reactor: reactor)
                        }
                    }
                }
                

                switch section.identity {
                case let .option(reactor):
                    return collectionView.dequeue(Reusable.optionCell, kind: .header, for: indexPath).then { cell in
                        if cell.reactor !== reactor {
                            cell.configure(reactor: reactor)
                        }
                    }
                default: return
                }
                
            },
            configureSupplementaryView: { dataSource, collectionView, _, indexPath in
                let section = dataSource[indexPath.section]
                
                switch section.identity {
                case let .recent(reactor), let .relatedSearch(reactor):
                    return collectionView.dequeue(Reusable.recentSearchHeaderView, kind: .header, for: indexPath).then { cell in
                        if cell.reactor !== reactor {
                            cell.configure(reactor: reactor)
                        }
                    }
                case let .topSearch(reactor):
                    return collectionView.dequeue(Reusable.topSerachHeaderView, kind: .header, for: indexPath).then { cell in
                        if cell.reactor !== reactor {
                            cell.configure(reactor: reactor)
                        }
                    }
                case let .searchResult(reactor):
                    return collectionView.dequeue(Reusable.resultSearchHeaderView, kind: .header, for: indexPath).then { cell in
                        if cell.reactor !== reactor {
                            cell.configure(reactor: reactor)
                        }
                    }
                default:
                    break
                }
            }
        )
    }
}
