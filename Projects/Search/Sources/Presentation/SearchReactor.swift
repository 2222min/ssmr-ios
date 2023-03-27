//
//  SearchReactor.swift
//  Search
//
//  Created mincheol on 2023/03/17.
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
        case viewDidLoad
        case didTapCategorySection
    }

	// MARK: State
	struct State {
        var sections: [SearchCategorySection] = []
        var sectionMap: [String: [SearchCategorySection.Item]] = [:]
    }

	// MARK: Mutation
	enum Mutation {
        case setSections
        case updateSection
    }

	// MARK: Mutate
	func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .viewDidLoad:
        return .just(.setSections)
    case .didTapCategorySection:
        return .just(.updateSection)
    }
  	}

	// MARK: Reduce
	func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .setSections:
        newState.createSection()
    case .updateSection:
        newState.reduceChangeExpand()
    }
    return newState
  }
}

extension SearchReactor.State {
    fileprivate mutating func createSection() {
        self.sections = []
        let firstElements: [SearchCategorySection.Item] = [
            .categoryItem(.init(cellReactor: [
                .init(name: "한식"),
                .init(name: "중식"),
                .init(name: "양식"),
                .init(name: "일식"),
                .init(name: "서양식"),
                .init(name: "세계음식"),
                .init(name: "기타")
            ]))
        ]
        let secondElements: [SearchCategorySection.Item] = [
            .categoryItem(.init(cellReactor: [
                .init(name: "전시관"),
                .init(name: "소공연장"),
                .init(name: "연극극장"),
                .init(name: "서점"),
                .init(name: "문화시설"),
                .init(name: "기타")
            ]))
        ]
        
        let mock: [SearchCategorySection] = [
            .init(
                identity: .category(.init(name: "음식점")),
                items: []
            ),
            .init(
                identity: .category(.init(name: "문화/예술")),
                items: []
            )
        ]
        self.sectionMap["음식점"] = firstElements
        self.sectionMap["문화/예술"] = secondElements
        self.sections = mock
    }
    
    fileprivate mutating func reduceChangeExpand(){
        
        self.sections.enumerated().forEach { index, section in
            guard case let .category(reactor) = section.identity else { return }
            let isExpand = reactor.currentState.isExpand
            let items = self.sectionMap[reactor.currentState.name].value ?? []
            print(self.sectionMap[reactor.currentState.name].value.flatMap{
                $0.flatMap {
                    switch $0 {
                    case let .categoryItem(value):
                        value.currentState.cellReactor.flatMap {
                            print($0.currentState.name)
                        }
                    }
                }
            })
            self.sections[index].items = isExpand ? items : []
        }
    }
}
