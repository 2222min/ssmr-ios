//
//  CategoryReactor.swift
//  Search
//
//  Created mincheol on 2023/03/17.
//  Copyright © 2023 team.io. All rights reserved.
//

import ReactorKit
import RxCocoa
import RxSwift

final class CategoryReactor: Reactor {
    
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
        case didTapTagItem(String)
    }
    
    // MARK: State
    struct State {
        var sections: [CategorySection] = []
        var sectionMap: [String: [CategorySection.Item]] = [:]
        var selectedTag: [CategorySection.Item] = []
    }
    
    // MARK: Mutation
    enum Mutation {
        case setSections
        case updateSection
        case updateTagSection
        case deleteTag(String)
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
        case let .didTapTagItem(value):
            return .just(.deleteTag(value))
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
        case let .deleteTag(value):
            newState.reduceChangeTagItems(name: value)
        }
        return newState
    }
}

extension CategoryReactor.State {
    fileprivate mutating func createSection() {
        self.sections = []
        let firstElements: [CategorySection.Item] = [
            .categoryItem(.init(name: "한식")),
            .categoryItem(.init(name: "중식")),
            .categoryItem(.init(name: "양식")),
            .categoryItem(.init(name: "일식")),
            .categoryItem(.init(name: "서양식")),
            .categoryItem(.init(name: "세계음식")),
            .categoryItem(.init(name: "기타"))
        ]
        let secondElements: [CategorySection.Item] = [
            .categoryItem(.init(name: "전시관")),
            .categoryItem(.init(name: "소공연장")),
            .categoryItem(.init(name: "연극극장")),
            .categoryItem(.init(name: "서점")),
            .categoryItem(.init(name: "문화시설")),
            .categoryItem(.init(name: "기타"))
        ]
        let thirdElements: [CategorySection.Item] = [
            .categoryItem(.init(name: "볼링")),
            .categoryItem(.init(name: "탁구")),
            .categoryItem(.init(name: "당구")),
            .categoryItem(.init(name: "스키장")),
            .categoryItem(.init(name: "썰매장")),
            .categoryItem(.init(name: "골프장")),
            .categoryItem(.init(name: "기타")),
        ]
        
        let mock: [CategorySection] = [
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
        var tagItem: [CategorySection.Item] = []
        let _ = self.sections.flatMap { section in
            section.items.compactMap { item in
                switch item {
                case let .categoryItem(reactor):
                    if reactor.currentState.isSelected {
                        tagItem.append(.tagItem(.init(name: reactor.currentState.name)))
                    }
                default:
                    return
                }
            }
        }
        
        self.sections = self.sections.compactMap { section in
            switch section.identity {
            case .category:
                return section
            case let .tag(reactor):
                return .init(identity: .tag(reactor), items: tagItem)
            }
        }
    }
    fileprivate mutating func reduceChangeTagItems(name: String) {
        var tagItem: [CategorySection.Item] = []
        var categorySection: [CategorySection] = []
        categorySection = self.sections.compactMap { section -> CategorySection in
            return .init(identity: section.identity, items: section.items.compactMap { item -> CategorySection.Item in
                switch item {
                case let .categoryItem(reactor):
                    if reactor.currentState.isSelected {
                        if reactor.currentState.name != name {
                            tagItem.append(.tagItem(.init(name: reactor.currentState.name)))
                            return .categoryItem(reactor)
                        } else {
                            return .categoryItem(.init(name: reactor.currentState.name, isSelected: !reactor.currentState.isSelected))
                        }
                    } else {
                        return .categoryItem(reactor)
                    }
                        
                case let .tagItem(reactor):
                    return .tagItem(reactor)
                }
            })
        }
        
        self.sections = categorySection.compactMap { section in
            switch section.identity {
            case .category:
                return section
            case let .tag(reactor):
                return .init(identity: .tag(reactor), items: tagItem)
            }
        }
    }
}
