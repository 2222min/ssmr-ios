//
//  SearchCategoryItemCellReactor.swift
//  Search
//
//  Created mincheol on 2023/03/19.
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
	enum Action {
        case didTapNameButton
    }

    // MARK: Mutation
    enum Mutation {
        case setIsSelected(Bool)
    }
    
	// MARK: State
	struct State {
        var name: String
        var isSelected: Bool = false
    }

	// MARK: Initializing
    init(name: String) {
		defer { _ = self.state }
        self.initialState = State(name: name)
	}
    
    // MARK: Mutate
    func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .didTapNameButton:
        return .just(.setIsSelected(!currentState.isSelected))
    }
      }

    // MARK: Reduce
    func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case let .setIsSelected(value):
        newState.isSelected = value
    }
    return newState
  }
    
}
