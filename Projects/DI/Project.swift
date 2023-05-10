//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by mincheol on 2023/04/29.
//

import ProjectDescription
import ProjectDescriptionHelpers

private let projectName = "DI"

let project = Project.framework(
    name: projectName,
    dependencies: [
        .project(target: "ThirdPartyLibManager", path: .relativeToCore("ThirdPartyLibManager"))
    ]
)
