//
//  OptionalType.swift
//  Util
//
//  Created by mincheol on 2023/03/19.
//  Copyright © 2023 team.io. All rights reserved.
//

import RxSwift

public protocol OptionalType {
    associatedtype Wrapped
    var value: Wrapped? { get }
}

extension Optional: OptionalType {
    /// Cast `Optional<Wrapped>` to `Wrapped?`
    public var value: Wrapped? {
        return self
    }
}

public extension ObservableType where Element: OptionalType {
    /**
     Unwraps and filters out `nil` elements.
     
     - returns: `Observable` of source `Observable`'s elements, with `nil` elements filtered out.
     */
    
    func filterNil() -> Observable<Element.Wrapped> {
        return self.flatMap { element -> Observable<Element.Wrapped> in
            guard let value = element.value else {
                return Observable<Element.Wrapped>.empty()
            }
            return Observable<Element.Wrapped>.just(value)
        }
    }
}
