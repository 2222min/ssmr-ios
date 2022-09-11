//
//  SignUpAPIProvider.swift
//  SignUp
//
//  Created by mincheol on 2022/09/11.
//  Copyright © 2022 team.io. All rights reserved.
//

import Moya
import RxSwift

class SignUpAPIProvider: ProviderProtocol {

    typealias T = SignUpAPI
    var provider: MoyaProvider<SignUpAPI>

    required init(isStub: Bool = false, sampleStatusCode: Int = 200, customEndpointClosure: ((T) -> Endpoint)? = nil) {
        provider = Self.consProvider(isStub, sampleStatusCode, customEndpointClosure)
    }

    func fetchUser() -> Single<User> {
        return request(type: User.self,
                       atKeyPath: "value",
                       target: .getUser)
    }
}
