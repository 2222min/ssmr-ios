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
import Domain

final class SignUpReactor: Reactor {

    // MARK: Constants
    private enum Constants { }

    // MARK: Properties
    let initialState: State = State()
    let effector: SignUpUseCaseProtocol
    // MARK: Initializing
    
    init(effector: SignUpUseCaseProtocol) {
        self.effector = effector
    }
    
    // MARK: Action
    enum Action {
        case didTapDuplicationButton(String)
    }
    
    // MARK: State
    struct State {
        var isSuccessCheckedId: Bool?
    }
    
    // MARK: Mutation
    enum Mutation {
        case checkedId(Bool)
    }
    
    // MARK: Mutate
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .didTapDuplicationButton(value):
            return self.checkedId(userId: value)
        }
    }
    
    // MARK: Reduce
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .checkedId(value):
            newState.isSuccessCheckedId = value
        }
        return newState
    }
}

extension SignUpReactor {
    private func checkedId(userId: String) -> Observable<Mutation> {
        let entity = CheckUserIdRequest.init(userId: userId)
        
        return self.effector.checkUserId(parmas: entity)
            .flatMap { _ -> Observable<Mutation> in
                return .just(.checkedId(true))
            }
            .catch { error in
                print("error::",error)
                return .just(.checkedId(false))
            }
    }
}
