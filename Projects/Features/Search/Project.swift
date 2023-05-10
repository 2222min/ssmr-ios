//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by mincheol on 2023/03/17.
//

import ProjectDescriptionHelpers
import ProjectDescription

private let projectName = "Search"

let infoPlist: [String: InfoPlist.Value] = [
    "UILaunchScreen": [:]
]

let project = Project.frameworkWithDemoApp(name: projectName,
                                           targets: [
                                            .SearchTargets.presentation.target,
                                            .SearchTargets.domain.target
                                           ],
                                           infoPlist: infoPlist,
                                           demoDependencies: Target.SearchTargets.allCases.map { .target(name: $0.rawValue)}
)
