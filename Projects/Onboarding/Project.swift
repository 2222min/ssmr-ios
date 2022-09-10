//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by mincheol on 2022/09/10.
//

import ProjectDescriptionHelpers
import ProjectDescription

private let projectName = "Onboarding"
private let iOSTargetVersion = "14.0"

let infoPlist: [String: InfoPlist.Value] = [
    "UILaunchScreen": [:]
]

let project = Project.frameworkWithDemoApp(name: projectName,
                                           platform: .iOS,
                                           iOSTargetVersion: iOSTargetVersion,
                                           infoPlist: infoPlist,
                                           dependencies: [
                                            .external(name: "SnapKit"),
                                            .external(name: "Then"),
                                            .external(name: "RxSwift"),
                                            .external(name: "RxCocoa"),
                                            .external(name: "ReactorKit"),
                                            .external(name: "Moya"),
                                            .external(name: "RxMoya"),
                                            .project(target: "CommonUI", path: .relativeToCurrentFile("../CommonUI"))
                                           ])

