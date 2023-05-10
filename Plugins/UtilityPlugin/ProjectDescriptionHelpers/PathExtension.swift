//
//  PathExtension.swift
//  Test
//
//  Created by mincheol on 2023/05/01.
//

import Foundation
import ProjectDescription

public typealias Dep = TargetDependency

public extension ProjectDescription.Path {
    static func relativeToFeature(_ pathString: String) -> Self {
        return .relativeToRoot("Projects/Features/\(pathString)")
    }
    static func relativeToCore() -> Self {
        return .relativeToRoot("Projects/Core")
    }
    static func relativeToCore(_ pathString: String) -> Self {
        return .relativeToRoot("Projects/Core/\(pathString)")
    }
    static var app: Self {
        return .relativeToRoot("Projects/App")
    }
}
