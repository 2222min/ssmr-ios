//
//  LoginEntity.swift
//  Core
//
//  Created by mincheol on 2023/03/01.
//  Copyright © 2023 team.io. All rights reserved.
//

import Foundation

public struct LoginEntity: Codable {
    let password: String
    let userId: String
    
    
    public init(userId: String, password: String) {
        self.userId = userId
        self.password = password
    }
}

public struct LoginReponse: Codable {
    let token: String?
}
