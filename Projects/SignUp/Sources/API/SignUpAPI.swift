//
//  SignUpAPI.swift
//  SignUp
//
//  Created by mincheol on 2022/09/11.
//  Copyright © 2022 team.io. All rights reserved.
//

import Moya
import Foundation
import Alamofire

enum SignUpAPI {
    case getUser
}

extension SignUpAPI: TargetType {
    var baseURL: URL {
        let url = "https://testurl/api/v1"
        return URL(string: url)!
    }
    
    var path: String {
        switch self {
        case .getUser:
            return "/user"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getUser:
            return .get
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
    var task: Task {
        switch self {
        case .getUser:
            return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getUser:
            return Data(
                """
                    {
                        "type": "success",
                        "value": {
                            "id": 20,
                            "name": "김김김"
                        }
                    }
                """.utf8
                )
        }
    }
}
