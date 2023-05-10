//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by mincheol on 2023/04/30.
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

private let projectName = "UI"

let project = Project.framework(
    name: projectName,
    dependencies: [
        .project(target: "ThirdPartyLibManager", path: .relativeToCore("ThirdPartyLibManager"))
    ]
)

