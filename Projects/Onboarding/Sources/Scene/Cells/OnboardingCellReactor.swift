//
//  OnboardingCellReactor.swift
//  Onboarding
//
//  Created mincheol on 2022/09/16.
//  Copyright © 2022 team.io. All rights reserved.
//

import RxCocoa
import RxSwift
import ReactorKit

final class OnboardingCellReactor: Reactor, IdentityHashable {
	
	// MARK: Constants
	private enum Constants { }

	// MARK: Properties
	let initialState: State 

	// MARK: Action 
	enum Action {}

	// MARK: Mutation
	enum Mutation {}

	// MARK: State
	struct State {}

	// MARK: Initializing
	init() {
		defer { _ = self.state }
		self.initialState = State()
	}
	
}
