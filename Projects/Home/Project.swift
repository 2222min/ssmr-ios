//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by mincheol on 2023/04/18.
//

import ProjectDescriptionHelpers
import ProjectDescription

private let projectName = "Home"

let infoPlist: [String: InfoPlist.Value] = [
    "UILaunchScreen": [:]
]

let project = Project.frameworkWithDemoApp(name: projectName,
                                           targets: [
                                            .HomeTargets.presentation.target,
                                            .HomeTargets.domain.target
                                           ],
                                           infoPlist: infoPlist,
                                           demoDependencies: Target.HomeTargets.allCases.map { .target(name: $0.rawValue)}
)

