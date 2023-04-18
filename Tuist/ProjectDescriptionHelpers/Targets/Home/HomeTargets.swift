//
//  HomeTargets.swift
//  ProjectDescriptionHelpers
//
//  Created by mincheol on 2023/04/18.
//

import ProjectDescription

extension Target {
    public enum HomeTargets: String, CaseIterable {
        case presentation = "HomePresentation"
        case domain = "HomeDomain"
    }
    
}

extension Target.HomeTargets {
    public var target: Target {
        switch self {
        case .presentation:
            return self.makePrentationTarget()
        case .domain:
            return self.makeDomainTarget()
        }
    }
}

extension Target.HomeTargets {
    func makePrentationTarget() -> Target {
        return Target (
            name: "HomePresentation",
            platform: .platform_ios,
            product: .framework,
            productName: "HomePresentation",
            bundleId: "team.io.HomePresentation",
            deploymentTarget: .targetVersion,
            infoPlist: .default,
            sources: [
                .glob(.relativeToManifest("Sources/Presentation/**"))
            ],
            resources: [
                .glob(pattern: .relativeToManifest("Resources/Presentation/**"))
            ],
            dependencies: [
                .project(target: "RxPresentationProxy", path: .relativeToManifest("../RxPresentationProxy")),
                .project(target: "CommonUI", path: .relativeToManifest("../CommonUI")),
                .project(target: "Util", path: .relativeToManifest("../Util")),
                .target(name: "HomeDomain")
            ]
        )
    }
    
    func makeDomainTarget() -> Target {
        return Target (
            name:"HomeDomain",
            platform: .platform_ios,
            product: .framework,
            productName: "HomeDomain",
            bundleId: "team.io.HomeDomain",
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
