//
//  HomeHashTagSection.swift
//  Home
//
//  Created by mincheol on 2023/05/27.
//  Copyright © 2023 team.io. All rights reserved.
//

import RxDataSources

struct HomeHashTagSection: Hashable {
    enum Identity: Hashable {
        case categoryTop
        case categoryBottom
    }
    let identity: Identity
    var items: [Item]
}

extension HomeHashTagSection: AnimatableSectionModelType {
    init(original: HomeHashTagSection, items: [Item]) {
        self = HomeHashTagSection(identity: original.identity, items: items)
    }
}

extension HomeHashTagSection {
    enum Item: Hashable {
        case categoryItem(HomeHashTagCellReactor)
    }
}

extension HomeHashTagSection.Identity: IdentifiableType {
    var identity: String {
        return "\(self.hashValue)"
    }
}

extension HomeHashTagSection.Item: IdentifiableType {
    var identity: String {
        return "\(self.hashValue)"
    }
}
