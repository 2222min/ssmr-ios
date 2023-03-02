//
//  BaseApi.swift
//  Core
//
//  Created by mincheol on 2023/03/01.
//  Copyright © 2023 team.io. All rights reserved.
//

import Foundation
import Moya

public protocol BaseAPI: TargetType {}

struct BaseApiError: Error, Codable {
    var reponseCode: Int?
    var errorType: String?
    var errorTarget: String?
    var errorReason: String?
    var errorCode: Int?
    var errorMessage: String?
    var rspCode: String?
    var rspMsg: String?
}

extension BaseAPI {
    public var baseURL: URL {
        guard let url = URL(string: baseUrl()) else { fatalError("Bad URL Request") }
        return url
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    public var sampleData: Data {
        guard let data = "Data".data(using: String.Encoding.utf8) else { return Data() }
        return data
    }
    
    public func baseUrl() -> String {
//        guard let url = Bundle.main.infoDictionary?["AppServerURL"] as? String
//        else { fatalError("Invalid Server URL") }
        return "http://15.165.19.23:8080"
    }
}

extension BaseApiError: LocalizedError {
    var errorDescription: String? {
        let msg = (errorMessage ?? "").isEmpty ? (rspMsg ?? "") : (errorMessage ?? "")
        return NSLocalizedString(msg.isEmpty ? defaultErrorMessage : msg  , comment: "serverError")
    }
}
