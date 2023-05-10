//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 정건호 on 2022/11/06.
//

import ProjectDescriptionHelpers
import ProjectDescription

private let projectName = "RegisterBusiness"
private let iOSTargetVersion = "14.0"

let infoPlist: [String: InfoPlist.Value] = [
    "UILaunchScreen": [:]
]

let project = Project.frameworkWithDemoApp(name: projectName,
                                           infoPlist: infoPlist,
                                           dependencies: [
                                            .project(target: "Core", path: .relativeToCore())
                                           ])

