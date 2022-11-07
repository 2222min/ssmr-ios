//
//  LoginReactor.swift
//  Login
//
//  Created by 정건호 on 2022/10/22.
//  Copyright © 2022 team.io. All rights reserved.
//

import CommonUI

import ReactorKit
import RxCocoa
import RxSwift
import UIKit

final public class LoginReactor: Reactor {
    
    // MARK: Constants
    private enum Constants { }

    // MARK: Properties
    public let initialState: State = State()

    // MARK: Initializing
    init() {}
    
    // MARK: Action
    public enum Action {
        case didTapCTAButton
    }
    
    // MARK: Mutation
    public enum Mutation {
        case showLoginFailView(Bool)
    }
    
    // MARK: State
    public struct State {
        var isShowLoginFailView = false
    }
    
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didTapCTAButton:
            return Observable.concat(
                Observable.just(.showLoginFailView(true)),
                Observable.just(.showLoginFailView(false))
            )
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .showLoginFailView(let isShow):
            newState.isShowLoginFailView = isShow
            return newState
        }
    }
    
}
