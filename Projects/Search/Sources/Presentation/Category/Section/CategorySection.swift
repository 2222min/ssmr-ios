//
//  SearchCategorySection.swift
//  Presentation
//
//  Created by mincheol on 2023/03/19.
//  Copyright © 2023 team.io. All rights reserved.
//

import RxDataSources

struct CategorySection: Hashable {
    enum Identity: Hashable {
        case tag(CategoryTagCellReactor)
        case category(CategoryHeaderCellReactor)
    }
    let identity: Identity
    var items: [Item]
}

extension CategorySection: AnimatableSectionModelType {
    init(original: CategorySection, items: [Item]) {
        self = CategorySection(identity: original.identity, items: items)
    }
}

extension CategorySection {
    enum Item: Hashable {
        case tagItem(CategoryTagItemCellReactor)
        case categoryItem(CategoryItemCellReactor)
    }
}

extension CategorySection.Item: IdentifiableType {
    var identity: String {
        return "\(self.hashValue)"
    }
}
