//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by mincheol on 2022/10/01.
//

import ProjectDescriptionHelpers
import ProjectDescription

private let projectName = "Util"
private let iOSTargetVersion = "14.0"

let project = Project.framework(
    name: projectName,
    dependencies: [
        .project(target: "ThirdPartyLibManager", path: .relativeToCore("ThirdPartyLibManager"))
    ]
)


