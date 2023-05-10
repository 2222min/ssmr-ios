//
//  LoginReactor.swift
//  SignUp
//
//  Created mincheol on 2022/09/11.
//  Copyright © 2022 team.io. All rights reserved.
//

import ReactorKit
import RxCocoa
import RxSwift

final class LoginReactor: Reactor {

	// MARK: Constants
	private enum Constants { }

	// MARK: Properties
	let initialState: State = State()

	// MARK: Initializing
	
    private let signUpProvider: SignUpAPIProvider
    
	init(signUpProvider: SignUpAPIProvider) {
        self.signUpProvider = signUpProvider
	}

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
