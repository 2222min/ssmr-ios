//
//  ReviewEntity.swift
//  Home
//
//  Created by 정건호 on 2023/05/02.
//  Copyright © 2023 team.io. All rights reserved.
//

import Foundation

struct ReviewEntity {
    let title: String
    let hashTag: [String]
    let writer: String
    let date: String
    let content: String
    let rating: Double
    let distance: String
    let image: URL?
}
