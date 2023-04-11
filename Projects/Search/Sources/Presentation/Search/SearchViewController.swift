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
	}

	// MARK: Constraints
	override func setupConstraints() {
		super.setupConstraints()
        self.serachTopBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
	}
}

// MARK: ReactorBind
extension SearchViewController {
	func bind(reactor: Reactor) { 
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
}
