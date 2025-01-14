//
//  Projects.swift
//  TuistManifests
//
//  Created by 이재훈 on 12/24/24.
//

import TuistExtensions
import ProjectDescription

let dependencies: [TargetDependency] = [
    .package(product: "KakaoSDKCommon", type: .runtime),
    .package(product: "KakaoSDKAuth", type: .runtime),
    .package(product: "KakaoSDKUser", type: .runtime),
//    Module.PassLib.project
]

let Demo = Project.app(
    name: "LoginModule",
    packages: [
        .remote(url: "https://github.com/kakao/kakao-ios-sdk", requirement: .upToNextMajor(from: "2.23.0"))
    ],
    dependencies: dependencies,
    resources: .default,
    sources: ["Sources/**"]
)

            