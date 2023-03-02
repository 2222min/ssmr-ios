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
                                           infoPlist: infoPlist,
                                           dependencies: [
                                            .external(name: "ReactorKit"),
                                            .project(target: "CommonUI", path: .relativeToCurrentFile("../CommonUI")),
                                            .project(target: "Util", path: .relativeToCurrentFile("../Util"))
                                           ])


