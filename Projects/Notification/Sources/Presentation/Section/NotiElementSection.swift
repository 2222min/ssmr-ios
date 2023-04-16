//
//  NotiElementSection.swift
//  NotificationDemoApp
//
//  Created by 정건호 on 2023/04/16.
//  Copyright © 2023 team.io. All rights reserved.
//

import RxDataSources

struct NotiElementSection {
    let header: String
    var items: [NotiElementEntity]
    
    init(header: String, items: [NotiElementEntity]) {
        self.header = header
        self.items = items
    }
}

extension NotiElementSection: SectionModelType {
    init(original: NotiElementSection, items: [NotiElementEntity]) {
        self = original
        self.items = items
    }
}
