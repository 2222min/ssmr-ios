//
//  SearchCategorySection.swift
//  Presentation
//
//  Created by mincheol on 2023/03/19.
//  Copyright © 2023 team.io. All rights reserved.
//

import RxDataSources

struct SearchCategorySection: Hashable {
    enum Identity: Hashable {
        case category(SearchCategoryCellReactor)
    }
    let identity: Identity
    var items: [Item]
}

extension SearchCategorySection: AnimatableSectionModelType {
    init(original: SearchCategorySection, items: [Item]) {
        self = SearchCategorySection(identity: original.identity, items: items)
    }
}

extension SearchCategorySection {
    enum Item: Hashable {
        case categoryItem(SearchCategoryItemsCellReactor)
    }
}

extension SearchCategorySection.Item: IdentifiableType {
    var identity: String {
        return "\(self.hashValue)"
    }
}
