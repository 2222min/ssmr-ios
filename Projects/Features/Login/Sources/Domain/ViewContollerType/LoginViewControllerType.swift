//
//  LoginViewControllerType.swift
//  LoginPresentation
//
//  Created by mincheol on 2023/04/30.
//  Copyright © 2023 team.io. All rights reserved.
//

import UI
public protocol LoginViewControllerType: ViewControllerType {}

public struct LoginViewControllerFactoryType: ViewControllerFactoryType {
    public struct Payload {
        public let paramA: String
        public init(paramA: String) {
            self.paramA = paramA
        }
    }
    public var factoryClosure: FactoryClosure
    public init(_ factoryClosure: @escaping FactoryClosure) {
        self.factoryClosure = factoryClosure
    }
    public func create(payload: Payload) -> ViewControllerType {
        return factoryClosure(payload)
    }
}
