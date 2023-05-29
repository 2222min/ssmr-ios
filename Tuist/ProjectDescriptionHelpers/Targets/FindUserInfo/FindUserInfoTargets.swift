//
//  FindUserInfoTargets.swift
//  ProjectDescriptionHelpers
//
//  Created by 정건호 on 2023/05/27.
//

import ProjectDescription
import UtilityPlugin

extension Target {
    public enum FindUserInfoTargets: String, CaseIterable {
        case presentation = "FindUserInfoPresentation"
        case domain = "FindUserInfoDomain"
    }
    
}

extension Target.FindUserInfoTargets {
    public var target: Target {
        switch self {
        case .presentation:
            return self.makePrentationTarget()
        case .domain:
            return self.makeDomainTarget()
        }
    }
}

extension Target.FindUserInfoTargets {
    func makePrentationTarget() -> Target {
        return Target (
            name: Self.presentation.rawValue,
            platform: .platform_ios,
            product: .framework,
            productName: Self.presentation.rawValue,
            bundleId: "team.io.\(Self.presentation.rawValue)",
            deploymentTarget: .targetVersion,
            infoPlist: .default,
            sources: [
                .glob(.relativeToManifest("Sources/Presentation/**"))
            ],
            resources: [
                .glob(pattern: .relativeToManifest("Resources/Presentation/**"))
            ],
            dependencies: [
                .project(target: "DI", path: .relativeToRoot("Projects/DI")),
                .project(target: "LoginDomain", path: .relativeToFeature("Login")),
                .target(name: "FindUserInfoDomain")
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
                .project(target: "Core", path: .relativeToCore())
            ]
        )
    }
}
