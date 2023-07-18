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
        static let recentSearchHeaderView = ReusableView<RecentSearchHeaderCollectionViewCell>()
        static let recentSearchCell = ReusableCell<RecentSearchCollectionViewCell>()
        static let relatedSearchCell = ReusableCell<RelatedSearchCollectionViewCell>()
    }
    
    // MARK: Properties
    private lazy var dataSource = self.createDataSource()
    // MARK: UI Properties
    private let searchTopBar = SearchTopBar().then {
        $0.deleteButtonIsHidden = false
        $0.borderColor = CommonUIAsset.pointColor.color.cgColor
        $0.borderWidth = 2
    }
    
    private lazy var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: self.createCompositionalLayout()
    ).then {
        $0.register(Reusable.recentSearchHeaderView, kind: .header)
        $0.register(Reusable.recentSearchCell)
        $0.register(Reusable.relatedSearchCell)
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
            $0.top.equalTo(self.searchTopBar.snp.bottom).offset(12)
            $0.leading.trailing.bottom.equalToSuperview()
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
            configureCell: {  _, collectionView, indexPath, sectionItem in
                switch sectionItem {
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
                }
            },
            configureSupplementaryView: { [weak self] dataSource, collectionView, _, indexPath in
                let section = dataSource[indexPath.section]
                
                switch section.identity {
                case let .recent(reactor):
                    return collectionView.dequeue(Reusable.recentSearchHeaderView, kind: .header, for: indexPath).then { cell in
                        if cell.reactor !== reactor {
                            cell.configure(reactor: reactor)
                        }
                    }
                }
            }
        )
    }
}
