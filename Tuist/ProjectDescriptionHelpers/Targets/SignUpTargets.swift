//
//  SignUpTargets.swift
//  ProjectDescriptionHelpers
//
//  Created by mincheol on 2023/03/04.
//

import ProjectDescription

extension Target {
    public enum SignUpTargets: String, CaseIterable {
        case presentation = "Presentation"
        case domain = "Domain"
    }
    
}

extension Target.SignUpTargets {
    public var target: Target {
        switch self {
        case .presentation:
            return self.makePrentationTarget()
        case .domain:
            return self.makeDomainTarget()
        }
    }
}

extension Target.SignUpTargets {
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
                .glob(pattern: .relativeToManifest("Resources/Presentation/**"))
            ],
            dependencies: [
                .project(target: "Core", path: .relativeToManifest("../Core"))
            ]
        )
    }
}

