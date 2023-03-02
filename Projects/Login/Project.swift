//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 정건호 on 2022/09/18.
//

import ProjectDescriptionHelpers
import ProjectDescription

private let projectName = "Login"
private let iOSTargetVersion = "14.0"

let infoPlist: [String: InfoPlist.Value] = [
    "UILaunchScreen": [:]
]

let project = Project.frameworkWithDemoApp(name: projectName,
                                           targets: [
                                            .LoginTargets.presentation.target,
                                            .LoginTargets.domain.target
                                           ],
                                           infoPlist: infoPlist,
                                           demoDependencies: Target.LoginTargets.allCases.map { .target(name: $0.rawValue)}
)

