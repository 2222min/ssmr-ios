//
//  LoginApi.swift
//  Core
//
//  Created by mincheol on 2023/03/01.
//  Copyright © 2023 team.io. All rights reserved.
//

import Foundation
import Moya

public enum LoginApi {
    case login(LoginEntity)
}

extension LoginApi: BaseAPI {
    public var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    
    public var task: Task {
        switch self {
        case let .login(params):
            return .requestJSONEncodable(params)
        }
    }
    
    public var baseURL: URL {
        guard let url = URL(string: baseUrl()) else { fatalError("Bad Request baseURL")}
        return url
    }
    
    public var path: String {
        switch self {
        case .login:
            return "/authenticate"
        }
    }
}
