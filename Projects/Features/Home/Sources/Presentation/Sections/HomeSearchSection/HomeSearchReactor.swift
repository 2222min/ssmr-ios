//
//  HomeSearchReactor.swift
//  Home
//
//  Created by mincheol on 2023/05/29.
//  Copyright © 2023 team.io. All rights reserved.
//

import ReactorKit
import RxCocoa
import RxSwift

final class HomeSearchReactor: Reactor {

    // MARK: Constants
    private enum Constants { }

    // MARK: Properties
    let initialState: State = State()

    // MARK: Initializing
    
    init() {}
    // MARK: Action
    enum Action {
        case viewDidLoad
    }

    // MARK: State
    struct State {
        var title: String?
        var hashTagList: [HomeHashTagSection]?
    }

    // MARK: Mutation
    enum Mutation {
        case setTitle(String)
        case setHashTagList([HomeHashTagSection])
    }

    // MARK: Mutate
    func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .viewDidLoad:
        return .concat(
            .just(.setTitle("지금 성북구, ☀️")),
            .just(.setHashTagList([
            .init(identity: .hashTag, items: [
                .hashTagItem(.init(hashTag: "#보리단길")),
                .hashTagItem(.init(hashTag: "#술")),
                .hashTagItem(.init(hashTag: "#파전땡기지않나요")),
                .hashTagItem(.init(hashTag: "#낮술")),
                .hashTagItem(.init(hashTag: "#피자땡겨요"))
            ])
        ]))
        )
    }
      }

    // MARK: Reduce
    func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case let .setTitle(value):
        newState.title = value
    case let .setHashTagList(value):
        newState.hashTagList = value
    }
    return newState
  }
}
