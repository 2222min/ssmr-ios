//
//  SearchResultCellReactor.swift
//  Search
//
//  Created mincheol on 2023/08/27.
//  Copyright © 2023 team.io. All rights reserved.
//

import RxCocoa
import RxSwift
import ReactorKit

final class SearchResultCellReactor: Reactor, IdentityHashable {
	
	// MARK: Constants
	private enum Constants { }

	// MARK: Properties
	let initialState: State 

	// MARK: Action 
	enum Action {}

	// MARK: Mutation
	enum Mutation {}

	// MARK: State
	struct State {}

	// MARK: Initializing
	init() {
		defer { _ = self.state }
		self.initialState = State()
	}
}
