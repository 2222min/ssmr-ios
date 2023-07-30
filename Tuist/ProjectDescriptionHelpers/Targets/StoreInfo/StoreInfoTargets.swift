//
//  StoreInfoTargets.swift
//  ProjectDescriptionHelpers
//
//  Created by 정건호 on 2023/07/30.
//

import ProjectDescription
import UtilityPlugin

extension Target {
    public enum StoreInfoTargets: String, CaseIterable {
        case presentation = "StoreInfoPresentation"
        case domain = "StoreInfoDomain"
    }
    
}

extension Target.StoreInfoTargets {
    public var target: Target {
        switch self {
        case .presentation:
            return self.makePrentationTarget()
        case .domain:
            return self.makeDomainTarget()
        }
    }
}

extension Target.StoreInfoTargets {
    func makePrentationTarget() -> Target {
        return Target (
            name: "StoreInfoPresentation",
            platform: .platform_ios,
            product: .framework,
            productName: "StoreInfoPresentation",
            bundleId: "team.io.StoreInfoPresentation",
            deploymentTarget: .targetVersion,
            infoPlist: .default,
            sources: [
                .glob(.relativeToManifest("Sources/Presentation/**"))
            ],
            resources: [
                .glob(pattern: .relativeToManifest("Resources/Presentation/**"))
            ],
            dependencies: [
                .project(target: "Core", path: .relativeToCore()),
                .target(name: "StoreInfoDomain")
            ]
        )
    }
    
    func makeDomainTarget() -> Target {
        return Target (
            name:"StoreInfoDomain",
            platform: .platform_ios,
            product: .framework,
            productName: "StoreInfoDomain",
            bundleId: "team.io.StoreInfoDomain",
            deploymentTarget: .targetVersion,
            infoPlist: .default,
            sources: [
                .glob(.relativeToManifest("Sources/Domain/**"))
            ],
            resources: [
                .glob(pattern: .relativeToManifest("Resources/Presentation/**"))
            ],
            dependencies: [
                .project(target: "Core", path: .relativeToCore())
            ]
        )
    }
}
