//
//  User.swift
//  HomeTests
//
//  Created by mincheol on 2022/09/11.
//  Copyright © 2022 team.io. All rights reserved.
//

import Foundation

struct UserResponse: Decodable {
    let type: String
    let value: User
}

struct User: Decodable, Equatable {
    let id: Int
    let name: String
}
