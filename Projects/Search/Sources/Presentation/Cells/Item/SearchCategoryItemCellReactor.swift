//
//  SearchCategoryItemCellReactor.swift
//  Search
//
//  Created mincheol on 2023/03/25.
//  Copyright © 2023 team.io. All rights reserved.
//

import RxCocoa
import RxSwift
import ReactorKit

final class SearchCategoryItemCellReactor: Reactor, IdentityHashable {
	
	// MARK: Constants
	private enum Constants { }

	// MARK: Properties
	let initialState: State 

	// MARK: Action 
	enum Action {}

	// MARK: Mutation
	enum Mutation {}

	// MARK: State
	struct State {
        var name: String
    }

	// MARK: Initializing
    init(name: String) {
		defer { _ = self.state }
        self.initialState = State(name: name)
	}
	
}
