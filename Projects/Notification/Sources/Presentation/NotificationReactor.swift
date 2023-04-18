//
//  NotificationReactor.swift
//  Notification
//
//  Created by 정건호 on 2023/04/16.
//  Copyright © 2023 team.io. All rights reserved.
//

import ReactorKit
import RxCocoa
import RxSwift

final class NotificationReactor: Reactor {
    // MARK: Constants
    private enum Constants { }
    
    // MARK: Properties
    let initialState: State = State()
    
    // MARK: Initializing
    
    init() {}
    
    // MARK: Action
    enum Action {
    }
    
    // MARK: State
    struct State {
        
    }
    
    // MARK: Mutation
    enum Mutation {
    }
    
    // MARK: Mutate
    func mutate(action: Action) -> Observable<Mutation> {
        
    }
    
    // MARK: Reduce
    func reduce(state: State, mutation: Mutation) -> State {
 
    }
}
