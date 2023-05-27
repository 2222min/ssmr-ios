//
//  FindUserInfoReactor.swift
//  FindUserInfo
//
//  Created mincheol on 2022/09/24.
//  Copyright © 2022 team.io. All rights reserved.
//

import ReactorKit
import RxCocoa
import RxSwift

public enum FindUserInfoType {
    case id
    case password
}

public final class FindUserInfoReactor: Reactor {

	// MARK: Constants
	private enum Constants { }

	// MARK: Properties
    public let initialState: State = State()

	// MARK: Initializing
	
    public init() {}

	// MARK: Action
	public enum Action {
        case didTapIdPager
        case didTapPwPager
    }

	// MARK: State
    public struct State {
        var findType: FindUserInfoType = .id
    }

	// MARK: Mutation
    public enum Mutation {
        case setFindType(FindUserInfoType)
    }

	// MARK: Mutate
    public func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .didTapIdPager:
        return .just(.setFindType(.id))
    case .didTapPwPager:
        return .just(.setFindType(.password))
    }
  	}

	// MARK: Reduce
    public func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case let .setFindType(value):
        newState.findType = value
    }
    return newState
  }
}
