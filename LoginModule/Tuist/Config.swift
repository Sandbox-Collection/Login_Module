//
//  Config.swift
//  Packages
//
//  Created by 이재훈 on 1/14/25.
//

import ProjectDescription

let config = Config(
    plugins: [
        .local(path: .relativeToRoot("Plugins/TuistExtensions"))
    ]
)
