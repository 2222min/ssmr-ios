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

public protocol SignUpUseCaseProtocol {
    func checkUserId(parmas: CheckUserIdRequest) -> Observable<Void>
}

public class SignUpUseCase: SignUpUseCaseProtocol {
    let networking: NetworkingProtocol
    
    public init(networking: NetworkingProtocol) {
        self.networking = networking
    }
    
    public func checkUserId(parmas: CheckUserIdRequest) -> Observable<Void> {
        return self.networking.request(SignUpApi.checkUserId(parmas))
            .asObservable()
            .map { _ in }
            .catch { error in
                return .error(error)
            }
    }
}
