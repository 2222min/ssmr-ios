//
//  ThanksLetterReactor.swift
//  ThanksLetterPresentation
//
//  Created by 정건호 on 2023/07/18.
//  Copyright © 2023 team.io. All rights reserved.
//

import ReactorKit
import RxCocoa
import RxSwift

final public class ThanksLetterReactor: Reactor {
    
    // MARK: Constants
    private enum Constants { }
    
    // MARK: Properties
    public let initialState: State = State()
    
    // MARK: Initializing
    
    public init() {}
    // MARK: Action
    public enum Action {
        case setTitle
    }
    
    // MARK: State
    public struct State {
        var title: String?
    }
    
    // MARK: Mutation
    public enum Mutation {
        case setTitle(String)
    }
    
    // MARK: Mutate
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .setTitle:
            return .just(.setTitle("봄이 성큼 다가오는 3월 2째주\n사장님의 땡스레터가 도착했어요!"))
        }
    }
    
    // MARK: Reduce
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setTitle(value):
            newState.title = value
        }
        return newState
    }
}
