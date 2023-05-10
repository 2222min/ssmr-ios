//
//  OnboardingTargets.swift
//  ProjectDescriptionHelpers
//
//  Created by mincheol on 2023/04/30.
//

import ProjectDescription
import UtilityPlugin

extension Target {
    public enum OnboardingTargets: String, CaseIterable {
        case presentation = "OnboardingPresentation"
    }
    
}

extension Target.OnboardingTargets {
    public var target: Target {
        switch self {
        case .presentation:
            return self.makePrentationTarget()
        }
    }
}

extension Target.OnboardingTargets {
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
                .project(target: "LoginDomain", path: .relativeToFeature("Login")),
                .project(target: "Core", path: .relativeToCore())
            ]
        )
    }
}

