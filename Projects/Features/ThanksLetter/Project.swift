//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 정건호 on 2023/07/18.
//

import ProjectDescriptionHelpers
import ProjectDescription

private let projectName = "ThanksLetter"

let infoPlist: [String: InfoPlist.Value] = [
    "UILaunchScreen": [:]
]

let project = Project.frameworkWithDemoApp(name: projectName,
                                           targets: [
                                            .ThanksLetterTargets.presentation.target,
                                            .ThanksLetterTargets.domain.target
                                           ],
                                           infoPlist: infoPlist,
                                           demoDependencies: Target.ThanksLetterTargets.allCases.map { .target(name: $0.rawValue)}
)
