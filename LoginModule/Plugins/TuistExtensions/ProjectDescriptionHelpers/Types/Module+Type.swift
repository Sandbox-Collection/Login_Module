//
//  Module.swift
//  TuistExtensions
//
//  Created by Importants on 12/4/24.
//

import ProjectDescription

public enum Module {
    case PassLib
    
    public var name: String {
        switch self {
        case .PassLib:
            return "PassLib"
        }
    }
    
    public var path: ProjectDescription.Path {
        .relativeToRoot("Projects/" + self.name)
    }
    
    public var project: TargetDependency {
        .project(target: self.name, path: self.path)
    }
}

extension Module: CaseIterable {}
