//
//  SearchCategoryCellReactor.swift
//  Search
//
//  Created mincheol on 2023/03/19.
//  Copyright © 2023 team.io. All rights reserved.
//

import RxCocoa
import RxSwift
import ReactorKit

final class SearchCategoryCellReactor: Reactor, IdentityHashable {
	
	// MARK: Constants
	private enum Constants { }

	// MARK: Properties
	let initialState: State 

	// MARK: Action 
	enum Action {
        case didTapCategoryButton
    }

	// MARK: Mutation
	enum Mutation {
        case setIsExpand(Bool)
    }

	// MARK: State
	struct State {
        var name: String
        var isExpand: Bool = false
    }

	// MARK: Initializing
    init(
        name: String
    ) {
		defer { _ = self.state }
        self.initialState = State(name: name)
	}
    
    // MARK: Mutate
    func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .didTapCategoryButton:
        return .just(.setIsExpand(!currentState.isExpand))
    }
      }

    // MARK: Reduce
    func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case let .setIsExpand(value):
        newState.isExpand = value
    }
    return newState
  }
    
}

