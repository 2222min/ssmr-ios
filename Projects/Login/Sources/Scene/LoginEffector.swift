//
//  LoginEffector.swift
//  Login
//
//  Created by mincheol on 2023/03/01.
//  Copyright © 2023 team.io. All rights reserved.
//

import Foundation
import RxSwift
import Core

protocol LoginEffectorProtocol {
    func login(parmas: LoginEntity) -> Observable<LoginReponse>
}

class LoginEffector: LoginEffectorProtocol {
    let networking: NetworkingProtocol
    
    init(networking: NetworkingProtocol) {
        self.networking = networking
    }
    
    func login(parmas: LoginEntity) -> Observable<LoginReponse> {
        return self.networking.request(LoginApi.login(parmas))
            .asObservable()
            .map(LoginReponse.self)
            .catch { error in
                return .error(error)
            }
    }
}
