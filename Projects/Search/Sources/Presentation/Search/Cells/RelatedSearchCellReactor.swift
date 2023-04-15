//
//  RelatedSearchCellReactor.swift
//  Search
//
//  Created mincheol on 2023/04/15.
//  Copyright © 2023 team.io. All rights reserved.
//

import RxCocoa
import RxSwift
import ReactorKit

final class RelatedSearchCellReactor: Reactor, IdentityHashable {
	
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
        var relatedWord: String
    }

	// MARK: Initializing
    init(relatedWork: String) {
		defer { _ = self.state }
		self.initialState = State(relatedWord: relatedWork)
	}
}
