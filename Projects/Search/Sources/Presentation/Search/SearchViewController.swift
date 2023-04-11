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

final class SearchViewController: BaseViewController, ReactorKit.View {
    
    typealias Reactor = SearchReactor
    
    // MARK: Constants
    private enum Constants { }
    
    // MARK: Properties
    
    // MARK: UI Properties
    private let serachTopBar = SerachTopBar().then {
        $0.deleteButtonIsHidden = false
        $0.borderColor = CommonUIAsset.pointColor.color.cgColor
        $0.borderWidth = 2
    }
    
    private let contentContainer = UIView()
    
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
       
        self.view.addSubview(self.serachTopBar)
        self.view.addSubview(self.contentContainer)
    }
    
    // MARK: Constraints
    override func setupConstraints() {
        super.setupConstraints()
        self.serachTopBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        self.contentContainer.snp.makeConstraints {
            $0.top.equalTo(self.serachTopBar.snp.bottom).offset(12)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: ReactorBind
extension SearchViewController {
    func bind(reactor: Reactor) {
        self.bindDidTapBackButton()
        self.bindTextFieldIsEditing()
    }
}

// MARK: Action
extension SearchViewController {}

// MARK: State
extension SearchViewController {}

// MARK: Func
extension SearchViewController {
    private func bindDidTapBackButton() {
        self.serachTopBar.rx.backButtonDidTap
            .asDriver()
            .drive(with: self, onNext: { _,_  in
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: self.disposeBag)
    }
    private func bindTextFieldIsEditing() {
        self.serachTopBar.rx.textFieldIsEditing
            .asDriver()
            .drive(with: self, onNext: { _, text in
                guard let text = text,
                      !text.isEmpty
                else {
                    self.addRecentSearchView()
                    return
                }
                self.addReusltSearchView()
            })
            .disposed(by: self.disposeBag)
    }
    private func addRecentSearchView() {
        if self.contentContainer.subviews.compactMap({ $0 as? RecentSearchView }).first != nil {
            return
        } else {
            let recentSearchView = RecentSearchView.init()
            self.contentContainer.subviews.forEach {
                $0.removeFromSuperview()
            }
            self.contentContainer.addSubview(recentSearchView)
            recentSearchView.snp.makeConstraints { $0.edges.equalToSuperview() }
        }
    }
    private func addReusltSearchView() {
        if self.contentContainer.subviews.compactMap({ $0 as? ResultSearchView }).first != nil {
            return
        } else {
            let resultSearchView = ResultSearchView.init()
            self.contentContainer.subviews.forEach {
                $0.removeFromSuperview()
            }
            self.contentContainer.addSubview(resultSearchView)
            resultSearchView.snp.makeConstraints { $0.edges.equalToSuperview() }
        }
    }

}
