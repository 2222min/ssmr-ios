//
//  RegisterBusinessTargets.swift
//  ProjectDescriptionHelpers
//
//  Created by 정건호 on 2023/05/28.
//

import ProjectDescription
import UtilityPlugin

extension Target {
    public enum RegisterBusinessTargets: String, CaseIterable {
        case presentation = "RegisterBusinessPresentation"
        case domain = "RegisterBusinessDomain"
    }
    
}

extension Target.RegisterBusinessTargets {
    public var target: Target {
        switch self {
        case .presentation:
            return self.makePrentationTarget()
        case .domain:
            return self.makeDomainTarget()
        }
    }
}

extension Target.RegisterBusinessTargets {
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
                .project(target: "SignUpDomain", path: .relativeToFeature("SignUp")),
                .target(name: "RegisterBusinessDomain")
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
