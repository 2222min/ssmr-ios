//
//  SearchTargets.swift
//  ProjectDescriptionHelpers
//
//  Created by mincheol on 2023/03/17.
//

import ProjectDescription

extension Target {
    public enum SearchTargets: String, CaseIterable {
        case presentation = "Presentation"
        case domain = "Domain"
    }
    
}

extension Target.SearchTargets {
    public var target: Target {
        switch self {
        case .presentation:
            return self.makePrentationTarget()
        case .domain:
            return self.makeDomainTarget()
        }
    }
}

extension Target.SearchTargets {
    func makePrentationTarget() -> Target {
        return Target (
            name: Self.presentation.rawValue,
            platform: .platform_ios,
            product: .framework,
            productName: Self.presentation.rawValue,
            bundleId: "team.io.\(Self.RawValue)",
            deploymentTarget: .targetVersion,
            infoPlist: .default,
            sources: [
                .glob(.relativeToManifest("Sources/Presentation/**"))
            ],
            resources: [
                .glob(pattern: .relativeToManifest("Resources/Presentation/**"))
            ],
            dependencies: [
                .external(name: "ReactorKit"),
                .external(name: "RxDataSources"),
                .external(name: "ReusableKit"),
                .project(target: "CommonUI", path: .relativeToManifest("../CommonUI")),
                .project(target: "Util", path: .relativeToManifest("../Util")),
                .target(name: "Domain")
            ]
        )
    }
    
    func makeDomainTarget() -> Target {
        return Target (
            name: Self.domain.rawValue,
            platform: .platform_ios,
            product: .framework,
            productName: Self.domain.rawValue,
            bundleId: "team.io.\(Self.domain.rawValue)",
            deploymentTarget: .targetVersion,
            infoPlist: .default,
            sources: [
                .glob(.relativeToManifest("Sources/Domain/**"))
            ],
            resources: [
                .glob(pattern: .relativeToManifest("Resources/Domain/**"))
            ],
            dependencies: [
                .project(target: "Core", path: .relativeToManifest("../Core"))
            ]
        )
    }
}
