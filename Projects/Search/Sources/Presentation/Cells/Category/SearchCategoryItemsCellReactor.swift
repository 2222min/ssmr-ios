//
//  SearchCategoryItemsCellReactor.swift
//  Search
//
//  Created mincheol on 2023/03/19.
//  Copyright © 2023 team.io. All rights reserved.
//

import RxCocoa
import RxSwift
import ReactorKit

final class SearchCategoryItemsCellReactor: Reactor, IdentityHashable {
	
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
        var cellReactor: [SearchCategoryItemCellReactor]
    }

	// MARK: Initializing
    init(cellReactor: [SearchCategoryItemCellReactor]) {
		defer { _ = self.state }
        self.initialState = State(cellReactor: cellReactor)
	}
}
