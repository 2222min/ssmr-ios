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
        case didTapCategoryItem
    }
    
    // MARK: State
    struct State {
        var sections: [SearchCategorySection] = []
        var sectionMap: [String: [SearchCategorySection.Item]] = [:]
        var selectedTag: [SearchCategorySection.Item] = []
    }
    
    // MARK: Mutation
    enum Mutation {
        case setSections
        case updateSection
        case updateTagSection
    }
    
    // MARK: Mutate
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return .just(.setSections)
        case .didTapCategorySection:
            return .just(.updateSection)
        case .didTapCategoryItem:
            return .just(.updateTagSection)
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
        case .updateTagSection:
            newState.reduceChangeTagItems()
        }
        return newState
    }
}

extension SearchReactor.State {
    fileprivate mutating func createSection() {
        self.sections = []
        let firstElements: [SearchCategorySection.Item] = [
            .categoryItem(.init(name: "한식")),
            .categoryItem(.init(name: "중식")),
            .categoryItem(.init(name: "양식")),
            .categoryItem(.init(name: "일식"))
        ]
        let secondElements: [SearchCategorySection.Item] = [
            .categoryItem(.init(name: "전시관")),
            .categoryItem(.init(name: "소공연장")),
            .categoryItem(.init(name: "연극극장")),
            .categoryItem(.init(name: "서점")),
            .categoryItem(.init(name: "문화시설")),
            .categoryItem(.init(name: "기타"))
        ]
        let thirdElements: [SearchCategorySection.Item] = [
            .categoryItem(.init(name: "전시관")),
            .categoryItem(.init(name: "소공연장")),
            .categoryItem(.init(name: "연극극장")),
            .categoryItem(.init(name: "서점")),
            .categoryItem(.init(name: "문화시설")),
            .categoryItem(.init(name: "기타")),
            .categoryItem(.init(name: "전시관")),
            .categoryItem(.init(name: "소공연장")),
            .categoryItem(.init(name: "연극극장")),
            .categoryItem(.init(name: "서점")),
            .categoryItem(.init(name: "문화시설")),
            .categoryItem(.init(name: "기타")),
            .categoryItem(.init(name: "전시관")),
            .categoryItem(.init(name: "소공연장")),
            .categoryItem(.init(name: "연극극장")),
            .categoryItem(.init(name: "서점")),
            .categoryItem(.init(name: "문화시설")),
            .categoryItem(.init(name: "기타"))
        ]
        
        let mock: [SearchCategorySection] = [
            .init(identity: .tag(.init()), items: []),
            .init(
                identity: .category(.init(name: "음식점")),
                items: []
            ),
            .init(
                identity: .category(.init(name: "문화/예술")),
                items: []
            ),
            .init(identity: .category(.init(name: "스포츠/레저")), items: [])
        ]
        self.sectionMap["음식점"] = firstElements
        self.sectionMap["문화/예술"] = secondElements
        self.sectionMap["스포츠/레저"] = thirdElements
        self.sections = mock
    }
    
    fileprivate mutating func reduceChangeExpand(){
        self.sections.enumerated().forEach { index, section in
            guard case let .category(reactor) = section.identity else { return }
            let isExpand = reactor.currentState.isExpand
            let items = self.sectionMap[reactor.currentState.name].value ?? []
            self.sections[index].items = isExpand ? items : []
        }
    }
    
    fileprivate mutating func reduceChangeTagItems() {
        var tagItem: [SearchCategorySection.Item] = []
        let _ = self.sections.flatMap { section in
            section.items.compactMap { item in
                switch item {
                case let .categoryItem(reactor):
                    if reactor.currentState.isSelected {
                        tagItem.append(item)
                    }
                default:
                    return
                }
            }
        }
        
        self.sections = self.sections.compactMap { section in
            switch section.identity {
            case .tag:
                return .init(identity: .tag(.init()), items: tagItem)
            default:
                return section
            }
        }
    }
}
