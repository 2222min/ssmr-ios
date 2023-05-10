//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 정건호 on 2023/03/26.
//

import ProjectDescriptionHelpers
import ProjectDescription
import UtilityPlugin

private let projectName = "Notification"
private let iOSTargetVersion = "14.0"

let infoPlist: [String: InfoPlist.Value] = [
    "UILaunchScreen": [:]
]

let project = Project.frameworkWithDemoApp(name: projectName,
                                           infoPlist: infoPlist,
                                           dependencies: [
                                            .project(target: "Core", path: .relativeToCore())
                                           ])


