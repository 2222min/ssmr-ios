//
//  RootReactor.swift
//  Root
//
//  Created mincheol on 2023/04/18.
//  Copyright © 2023 team.io. All rights reserved.
//

import ReactorKit
import RxCocoa
import RxSwift

final class RootReactor: Reactor {

	// MARK: Constants
	private enum Constants { }

	// MARK: Properties
	let initialState: State = State()

	// MARK: Initializing
	
	init() {}
	// MARK: Action
	enum Action {}

	// MARK: State
	struct State {}

	// MARK: Mutation
	enum Mutation {}

	// MARK: Mutate
	func mutate(action: Action) -> Observable<Mutation> {
    switch action {}
  	}

	// MARK: Reduce
	func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {}
    return newState
  }
}
