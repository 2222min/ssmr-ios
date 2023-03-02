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
                                           platform: .iOS,
                                           iOSTargetVersion: iOSTargetVersion,
                                           infoPlist: infoPlist,
                                           dependencies: [
                                            .external(name: "ReactorKit"),
                                            .project(target: "CommonUI", path: .relativeToCurrentFile("../CommonUI")),
                                            .project(target: "Util", path: .relativeToCurrentFile("../Util")),
                                            .project(target: "Core", path: "../Core")
                                           ])

