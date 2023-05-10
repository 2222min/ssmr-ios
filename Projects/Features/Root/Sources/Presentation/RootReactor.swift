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

final public class RootReactor: Reactor {

	// MARK: Constants
	private enum Constants { }

	// MARK: Properties
    public let initialState: State = State()

	// MARK: Initializing
	
	public init() {}
	// MARK: Action
    public enum Action {}

	// MARK: State
    public struct State {}

	// MARK: Mutation
    public enum Mutation {}

	// MARK: Mutate
    public func mutate(action: Action) -> Observable<Mutation> {
    switch action {}
  	}

	// MARK: Reduce
    public func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {}
    return newState
  }
}
