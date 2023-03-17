//
//  SignUpApi.swift
//  Presentation
//
//  Created by mincheol on 2023/03/04.
//  Copyright © 2023 team.io. All rights reserved.
//

import Foundation
import Core
import Moya

public enum SignUpApi {
    case checkUserId(CheckUserIdRequest)
}

extension SignUpApi: BaseAPI {
    public var method: Moya.Method {
        switch self {
        case .checkUserId:
            return .post
        }
    }
    
    public var task: Task {
        switch self {
        case let .checkUserId(params):
            return .requestJSONEncodable(params)
        }
    }
    
    public var baseURL: URL {
        guard let url = URL(string: baseUrl()) else { fatalError("Bad Request baseURL")}
        return url
    }
    
    public var path: String {
        switch self {
        case .checkUserId:
            return "/user/checkId"
        }
    }
}

