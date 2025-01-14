//
//  App+Build.swift
//  AppExtensions
//
//  Created by Importants on 12/4/24.
//

import ProjectDescription

public extension Project {
    static let appName: String = "LoginModule"
    
    static let productName: String = "LoginModule"
    
    static let deployTarget: DeploymentTargets = .iOS("16.0")
    
    static let teamId = "com.cudo"
    
    static let appPath: ProjectDescription.Path = .relativeToRoot("Projects/App")
}
