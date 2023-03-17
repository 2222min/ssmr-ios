//
//  CheckUserIdRequest.swift
//  HomeTests
//
//  Created by mincheol on 2022/09/11.
//  Copyright © 2022 team.io. All rights reserved.
//

import Foundation

public struct CheckUserIdRequest: Codable {
    public let userId: String
    
    public init(userId: String) {
        self.userId = userId
    }
}
