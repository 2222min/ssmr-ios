//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by mincheol on 2023/04/18.
//

import ProjectDescriptionHelpers
import ProjectDescription

private let projectName = "Root"

let infoPlist: [String: InfoPlist.Value] = [
    "UILaunchScreen": [:]
]

let project = Project.frameworkWithDemoApp(name: projectName,
                                           targets: [
                                            .RootTarget.presentation.target,
                                            .RootTarget.domain.target
                                           ],
                                           infoPlist: infoPlist,
                                           demoDependencies: Target.RootTarget.allCases.map { .target(name: $0.rawValue)}
)
