//
//  RecentSearchCellReactor.swift
//  Search
//
//  Created mincheol on 2023/04/11.
//  Copyright © 2023 team.io. All rights reserved.
//

import RxCocoa
import RxSwift
import ReactorKit

final class RecentSearchCellReactor: Reactor, IdentityHashable {
	
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
        var recentWord: String
    }

	// MARK: Initializing
    init(recentWord: String) {
		defer { _ = self.state }
        self.initialState = State(recentWord: recentWord)
	}

}
