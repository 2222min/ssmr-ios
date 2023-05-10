//
//  RootTarget.swift
//  ProjectDescriptionHelpers
//
//  Created by mincheol on 2023/04/18.
//

import ProjectDescription
import UtilityPlugin

extension Target {
    public enum RootTarget: String, CaseIterable {
        case presentation = "RootPresentation"
        case domain = "RootDomain"
    }
    
}

extension Target.RootTarget {
    public var target: Target {
        switch self {
        case .presentation:
            return self.makePrentationTarget()
        case .domain:
            return self.makeDomainTarget()
        }
    }
}

extension Target.RootTarget {
    func makePrentationTarget() -> Target {
        return Target (
            name: "RootPresentation",
            platform: .platform_ios,
            product: .framework,
            productName: "RootPresentation",
            bundleId: "team.io.RootPresentation",
            deploymentTarget: .targetVersion,
            infoPlist: .default,
            sources: [
                .glob(.relativeToManifest("Sources/Presentation/**"))
            ],
            resources: [
                .glob(pattern: .relativeToManifest("Resources/Presentation/**"))
            ],
            dependencies: [
                .project(target: "HomePresentation", path: .relativeToFeature("Home")),
                .target(name: "RootDomain")
            ]
        )
    }
    
    func makeDomainTarget() -> Target {
        return Target (
            name: Self.domain.rawValue,
            platform: .platform_ios,
            product: .framework,
            productName: "RootDomain",
            bundleId: "team.io.RootDomain",
            deploymentTarget: .targetVersion,
            infoPlist: .default,
            sources: [
                .glob(.relativeToManifest("Sources/Domain/**"))
            ],
            resources: [
                .glob(pattern: .relativeToManifest("Resources/Domain/**"))
            ],
            dependencies: [
                .project(target: "Core", path: .relativeToCore())
            ]
        )
    }
}
