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
	}

	override func configureUI() {
		super.configureUI()
	}

	// MARK: Constraints
	override func setupConstraints() {
		super.setupConstraints()
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
extension SearchViewController {}
