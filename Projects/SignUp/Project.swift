//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by mincheol on 2022/09/11.
//

import ProjectDescriptionHelpers
import ProjectDescription

private let projectName = "SignUp"
private let iOSTargetVersion = "14.0"

let infoPlist: [String: InfoPlist.Value] = [
    "UILaunchScreen": [:]
]

let project = Project.frameworkWithDemoApp(name: projectName,
                                           targets: [
                                            .SignUpTargets.presentation.target,
                                            .SignUpTargets.domain.target
                                           ],
                                           infoPlist: infoPlist,
                                           demoDependencies: Target.SignUpTargets.allCases.map { .target(name: $0.rawValue)})


