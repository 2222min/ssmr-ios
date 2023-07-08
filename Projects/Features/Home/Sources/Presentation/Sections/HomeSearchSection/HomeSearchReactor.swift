//
//  HomeSearchReactor.swift
//  Home
//
//  Created by mincheol on 2023/05/29.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit
import ReactorKit
import RxCocoa
import RxSwift
import CommonUI

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
            .init(identity: .categoryTop, items: [
                .categoryItem(.init(hashTag: "음식점", image: CommonUIAsset.restaurantIcon.image)),
                .categoryItem(.init(hashTag: "문화/예술", image: CommonUIAsset.restaurantIcon.image)),
                .categoryItem(.init(hashTag: "스포츠/레저", image: CommonUIAsset.restaurantIcon.image)),
                .categoryItem(.init(hashTag: "D.I.Y", image: CommonUIAsset.restaurantIcon.image))
            ]),
            .init(identity: .categoryBottom, items: [
                .categoryItem(.init(hashTag: "오락", image: CommonUIAsset.restaurantIcon.image)),
                .categoryItem(.init(hashTag: "테마파크", image: CommonUIAsset.restaurantIcon.image)),
                .categoryItem(.init(hashTag: "음료전문점", image: CommonUIAsset.restaurantIcon.image))
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
