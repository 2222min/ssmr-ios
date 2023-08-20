//
//  TopSearchCollectionViewCellReactor.swift
//  Search
//
//  Created by mincheol on 2023/08/20.
//  Copyright © 2023 team.io. All rights reserved.
//

import RxCocoa
import RxSwift
import ReactorKit

final class TopSearchCollectionViewCellReactor: Reactor, IdentityHashable {
    
    // MARK: Constants
    private enum Constants { }

    // MARK: Properties
    let initialState: State

    // MARK: Action
    enum Action {}

    // MARK: Mutation
    enum Mutation {}

    // MARK: State
    struct State {
        var topSearchItem: String
    }

    // MARK: Initializing
    init(topSearchItem: String) {
        defer { _ = self.state }
        self.initialState = State(topSearchItem: topSearchItem)
    }
}

