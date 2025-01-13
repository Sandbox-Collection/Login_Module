//
//  Defines.swift
//  LoginModuleApp
//
//  Created by Importants on 1/14/25.
//

import Foundation

public struct LoginDTO {
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

public enum LoginError: Error {
    case invalidNonce
    case invalidResponse
    case invalidState
    case invalidCredentials
    case invalidSignature
    case invalidUser
}
