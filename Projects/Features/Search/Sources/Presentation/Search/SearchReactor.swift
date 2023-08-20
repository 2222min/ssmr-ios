//
//  SearchReactor.swift
//  Search
//
//  Created mincheol on 2023/04/11.
//  Copyright © 2023 team.io. All rights reserved.
//

import ReactorKit
import RxCocoa
import RxSwift

final class SearchReactor: Reactor {

	// MARK: Constants
	private enum Constants { }

	// MARK: Properties
	let initialState: State = State()

	// MARK: Initializing
	
	init() {}

	// MARK: Action
	enum Action {
        case showRecentSearchView
        case showResultSearchView
    }

	// MARK: State
	struct State {
        var searchView: [SearchSection] = []
    }

	// MARK: Mutation
	enum Mutation {
        case setRecentSearchView([SearchSection])
        case setResultSearchView([SearchSection])
    }

	// MARK: Mutate
	func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .showRecentSearchView:
        return self.setRecentSearchView()
    case .showResultSearchView:
        return self.setResultSearchView()
    }
  	}

	// MARK: Reduce
	func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case let .setRecentSearchView(value):
        newState.searchView = value
    case let .setResultSearchView(value):
        newState.searchView = value
    }
    return newState
  }
}

extension SearchReactor {
    private func setRecentSearchView() -> Observable<Mutation> {
        return .just(.setRecentSearchView([
            .init(identity: .topSearch, items: [
                .topSearch(.init(topSearchItem: "마라탕")),
                .topSearch(.init(topSearchItem: "반미")),
                .topSearch(.init(topSearchItem: "마라탕")),
                .topSearch(.init(topSearchItem: "반미")),
                .topSearch(.init(topSearchItem: "마라탕")),
                .topSearch(.init(topSearchItem: "반미")),
                .topSearch(.init(topSearchItem: "마라탕")),
                .topSearch(.init(topSearchItem: "반미")),
                .topSearch(.init(topSearchItem: "마라탕")),
                .topSearch(.init(topSearchItem: "반미"))
            ]),
            .init(identity: .recent(.init(isHidden: false)), items: [
                .recentSearch(.init(recentWord: "마라탕")),
                .recentSearch(.init(recentWord: "이자카야")),
                .recentSearch(.init(recentWord: "송리단길"))
            ])
        ]))
    }
    private func setResultSearchView() -> Observable<Mutation> {
        return .just(.setResultSearchView([
            .init(identity: .relatedSearch(.init(isHidden: true)), items: [
                .relatedSearch(.init(relatedWork: "마라탕")),
                .relatedSearch(.init(relatedWork: "마라샹궈")),
                .relatedSearch(.init(relatedWork: "마늘치킨")),
                .relatedSearch(.init(relatedWork: "마늘바게트"))
            ])
        ]))
    }
}
