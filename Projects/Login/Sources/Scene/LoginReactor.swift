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
        case didTapCTAButton
    }
    
    // MARK: State
    public struct State {
        var isPresentedLoginFailView = false
    }
    
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didTapCTAButton:
            return Observable.just(.didTapCTAButton)
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .didTapCTAButton:
            if state.isPresentedLoginFailView {
                newState.isPresentedLoginFailView.toggle()
            } else {
                newState.isPresentedLoginFailView.toggle()
            }
            return newState
        }
    }
    
}
