//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by mincheol on 2022/09/10.
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

private let projectName = "App"
private let iOSTargetVersion = "14.0"

let infoPlistPath: String = "Resources/App.plist"
let project = Project.app(
    name: projectName,
    infoPlist: infoPlistPath,
    dependencies: [
        .project(target: "Features", path: .relativeToManifest("../Features"))
    ]
)
