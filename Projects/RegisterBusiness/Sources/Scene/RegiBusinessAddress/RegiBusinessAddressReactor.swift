//
//  RegiBusinessAddressReactor.swift
//  RegisterBusiness
//
//  Created by mincheol on 2023/02/19.
//  Copyright © 2023 team.io. All rights reserved.
//

import ReactorKit

class RegiBusinessAddressReactor: Reactor {
    
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
        switch action {
        }
    }
    
    // MARK: Reduce
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
            
        }
        return newState
    }
}
