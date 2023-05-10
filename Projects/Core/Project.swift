//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by mincheol on 2023/03/01.
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

private let projectName = "Core"
private let iOSTargetVersion = "14.0"

let project = Project.framework(
    name: projectName,
    dependencies: [
        .project(target: "CommonUI", path: .relativeToCore("CommonUI")),
        .project(target: "UI", path: .relativeToCore("UI")),
        .project(target: "Util", path: .relativeToCore("Util"))
    ]
)

