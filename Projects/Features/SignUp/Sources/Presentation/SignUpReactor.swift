//
//  SignUpReactor.swift
//  SignUp
//
//  Created by 정건호 on 2022/10/26.
//  Copyright © 2022 team.io. All rights reserved.
//

import ReactorKit
import RxCocoa
import RxSwift

public final class SignUpReactor: Reactor {

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

