//
//  DeploymentTarget+EX.swift
//  ProjectDescriptionHelpers
//
//  Created by mincheol on 2023/03/02.
//

import ProjectDescription

extension DeploymentTarget {
    static let targetVersion: DeploymentTarget = .iOS(targetVersion: "16.0", devices: [.iphone])
}
