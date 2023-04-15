//
//  RecentSearchHeaderCellReactor.swift
//  Search
//
//  Created mincheol on 2023/04/15.
//  Copyright © 2023 team.io. All rights reserved.
//

import RxCocoa
import RxSwift
import ReactorKit

final class RecentSearchHeaderCellReactor: Reactor, IdentityHashable {
	
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
        var isHidden: Bool
    }

	// MARK: Initializing
    init(isHidden: Bool) {
		defer { _ = self.state }
		self.initialState = State(isHidden: isHidden)
	}
}
