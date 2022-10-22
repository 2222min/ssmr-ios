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
    }
    
    // MARK: Mutation
    public enum Mutation {
    }
    
    // MARK: State
    public struct State {
    }
    
    // MARK: Mutate
    public func mutate(action: Action) -> Observable<Mutation> {
        
    }
    
}
