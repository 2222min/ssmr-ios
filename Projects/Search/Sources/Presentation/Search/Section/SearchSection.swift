//
//  SearchSection.swift
//  Presentation
//
//  Created by mincheol on 2023/04/15.
//  Copyright © 2023 team.io. All rights reserved.
//

import RxDataSources

struct SearchSection: Hashable {
    enum Identity: Hashable {
        case recent(RecentSearchHeaderCellReactor)
    }
    let identity: Identity
    var items: [Item]
}

extension SearchSection: AnimatableSectionModelType {
    init(original: SearchSection, items: [Item]) {
        self = SearchSection(identity: original.identity, items: items)
    }
}

extension SearchSection {
    enum Item: Hashable {
        case recentSearch(RecentSearchCellReactor)
        case relatedSearch(RelatedSearchCellReactor)
    }
}

extension SearchSection.Item: IdentifiableType {
    var identity: String {
        return "\(self.hashValue)"
    }
}
