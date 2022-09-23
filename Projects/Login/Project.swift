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
                                            .external(name: "SnapKit"),
                                            .external(name: "Then"),
                                            .external(name: "RxSwift"),
                                            .external(name: "RxCocoa"),
                                            .external(name: "ReactorKit"),
                                            .external(name: "Moya"),
                                            .external(name: "RxMoya"),
                                            .external(name: "BonMot"),
                                            .project(target: "CommonUI", path: .relativeToCurrentFile("../CommonUI"))
                                           ])
