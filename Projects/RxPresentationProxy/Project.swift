//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by mincheol on 2023/04/11.
//

import ProjectDescription
import ProjectDescriptionHelpers

private let projectName = "RxPresentationProxy"
let project = Project.proxyFramework(
    name: projectName,
    dependencies: [
        .external(name: "ReactorKit"),
        .external(name: "RxDataSources"),
        .external(name: "ReusableKit"),
        .project(target: "RxProxy", path:
                .relativeToCurrentFile("../RxProxy"))
    ]
)
