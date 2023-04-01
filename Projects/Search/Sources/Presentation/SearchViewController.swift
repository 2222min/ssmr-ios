//
//  SearchViewController.swift
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

final class SearchViewController: BaseViewController, ReactorKit.View {
    typealias Reactor = SearchReactor
    typealias Category = RxCollectionViewSectionedAnimatedDataSource<SearchCategorySection>
    // MARK: Constants
    private enum Constants { }
    
    enum Reusable {
        static let categoryCell = ReusableView<SearchCategoryCollectionViewCell>()
        static let categoryItemCell = ReusableCell<SearchCategoryItemsCollectionViewCell>()
    }
    
    // MARK: Properties
    private lazy var dataSource = self.createDataSource()
    private let flowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.minimumInteritemSpacing = 0
        $0.minimumLineSpacing = 0
    }
    
    // MARK: UI Properties
    private let serachTopBar = SerachTopBar()
    private lazy var collectionView: DynamicHeightCollectionView = .init(
        frame: .zero,
        collectionViewLayout: self.flowLayout
    ).then {
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
extension SearchViewController {
    func bind(reactor: Reactor) {
        self.collectionViewDelegateBind(reactor: reactor)
        self.bindState(sections: reactor)
    }
}

// MARK: Action
extension SearchViewController {}

// MARK: State
extension SearchViewController {
    private func bindState(sections reactor: Reactor) {
        reactor.state.map { $0.sections }
            .asDriver(onErrorJustReturn: [])
            .drive(self.collectionView.rx.items(dataSource: self.dataSource))
            .disposed(by: self.disposeBag)
    }
}

// MARK: Func

extension SearchViewController {
    public static func create() -> SearchViewController {
        let reactor: SearchReactor = .init()
        let viewController = SearchViewController.init(reactor: reactor)
        
        return viewController
    }
    
    fileprivate func createDataSource() -> Category {
        return .init(
            configureCell: {  _, collectionView, indexPath, sectionItem in
                switch sectionItem {
                case .categoryItem(let reactor):
                    return collectionView.dequeue(Reusable.categoryItemCell, for: indexPath).then { cell in
                        if cell.reactor !== reactor {
                            cell.configure(reactor: reactor)
                        }
                    }
                }
            },
            configureSupplementaryView: { [weak self] dataSource, collectionView, _, indexPath in
              let section = dataSource[indexPath.section]
              
              switch section.identity {
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
    
    private func collectionViewDelegateBind(reactor: Reactor) {
        self.collectionView.rx.setDelegate(self).disposed(by: self.disposeBag)
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



extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let sectionItem = self.dataSource[indexPath]
        let width = UIScreen.main.bounds.width
        
        switch sectionItem {
        case let .categoryItem(cellReactor):
            return Reusable.categoryItemCell.class.size(
                width: width,
                cellReactor: cellReactor
            )
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
      let section = self.dataSource[section]
      let width = collectionView.bounds.width
      switch section.identity {
      case .category: return Reusable.categoryCell.class.size(width: width)
      }
    }
}
