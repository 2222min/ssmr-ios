//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by mincheol on 2023/03/01.
//

import ProjectDescription
import ProjectDescriptionHelpers

private let projectName = "Core"
private let iOSTargetVersion = "14.0"

let project = Project.framework(
    name: projectName,
    dependencies: [
        .external(name: "Moya"),
        .external(name: "RxMoya"),
        .external(name: "RxSwift"),
        .external(name: "RxCocoa")
    ]
)

