//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by mincheol on 2022/09/10.
//

import ProjectDescriptionHelpers
import ProjectDescription

private let projectName = "Onboarding"
private let iOSTargetVersion = "14.0"

let infoPlist: [String: InfoPlist.Value] = [
    "UILaunchScreen": [:]
]

let project = Project.frameworkWithDemoApp(name: projectName,
                                           targets: [
                                            .OnboardingTargets.presentation.target
                                           ],
                                           infoPlist: infoPlist,
                                           demoDependencies: Target.OnboardingTargets.allCases.map { .target(name: $0.rawValue)}
)

