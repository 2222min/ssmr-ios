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

final class SignUpReactor: Reactor {

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

