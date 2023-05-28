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
import LoginDomain

final public class LoginReactor: Reactor {
    
    // MARK: Constants
    private enum Constants { }

    // MARK: Properties
    public let initialState: State = State()
    private let effector: LoginUseCaseProtocol
    // MARK: Initializing
    public init(effector: LoginUseCaseProtocol) {
        self.effector = effector
    }
    
    // MARK: Action
    public enum Action {
        case didTapCTAButton
        case didTapFindInfoButton
        case didTapSignUpButton
    }
    
    // MARK: Mutation
    public enum Mutation {
        case showLoginFailView(Bool)
        case showFindInfoView(Bool)
        case showSignUpView(Bool)
    }
    
    // MARK: State
    public struct State {
        var isShowLoginFailView = false
        var isShowFindInfoView = false
        var isShowSignUpView = false
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didTapCTAButton:
            return self.effector.login(parmas: LoginEntity.init(userId: "jun", password: "1234"))
                .flatMap { data -> Observable<Mutation> in
                    print("로그인 성공")
                    return .empty()
                }
                .catch { error -> Observable<Mutation>in
                    return Observable.concat(
                        Observable.just(.showLoginFailView(true)),
                        Observable.just(.showLoginFailView(false))
                    )
                }
        case .didTapFindInfoButton:
            return Observable.concat(
                Observable.just(.showFindInfoView(true)),
                Observable.just(.showFindInfoView(false))
            )
        case .didTapSignUpButton:
            return Observable.concat(
                Observable.just(.showSignUpView(true)),
                Observable.just(.showSignUpView(false))
            )
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .showLoginFailView(let isShow):
            newState.isShowLoginFailView = isShow
            return newState
        case .showFindInfoView(let isShow):
            newState.isShowFindInfoView = isShow
            return newState
        case .showSignUpView(let isShow):
            newState.isShowSignUpView = isShow
            return newState
        }
    }
    
}




