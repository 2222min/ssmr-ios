//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by mincheol on 2022/09/24.
//

import ProjectDescriptionHelpers
import ProjectDescription
import UtilityPlugin

private let projectName = "FindUserInfo"
private let iOSTargetVersion = "14.0"

let infoPlist: [String: InfoPlist.Value] = [
    "UILaunchScreen": [:]
]

let project = Project.frameworkWithDemoApp(name: projectName,
                                           targets: [
                                            .FindUserInfoTargets.presentation.target,
                                            .FindUserInfoTargets.domain.target
                                           ],
                                           infoPlist: infoPlist,
                                           demoDependencies: Target.FindUserInfoTargets.allCases.map { .target(name: $0.rawValue)}
)
