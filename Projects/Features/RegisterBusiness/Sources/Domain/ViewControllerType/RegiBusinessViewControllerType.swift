//
//  RegiBusinessViewControllerType.swift
//  RegisterBusinessPresentation
//
//  Created by 정건호 on 2023/05/28.
//  Copyright © 2023 team.io. All rights reserved.
//

import UI
public protocol RegiBusinessViewControllerType: ViewControllerType {}

public struct RegiBusinessViewControllerFactoryType: ViewControllerFactoryType {
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
