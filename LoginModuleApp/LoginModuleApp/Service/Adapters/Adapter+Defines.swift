//
//  Defines.swift
//  LoginModuleApp
//
//  Created by Importants on 1/14/25.
//

import Foundation

public struct LoginModel {
    var nonce: String
    var userIdentifier: String
    
    init(
        nonce: String,
        userIdentifier: String
    ) {
        self.nonce = nonce
        self.userIdentifier = userIdentifier
    }
}

public enum LoginType {
    case kakao
    case apple
}

public protocol LoginAdapterInterface {
    func handleSignIn(
        type: LoginType
    ) async throws -> LoginModel
}
