//
//  Defines.swift
//  LoginModuleApp
//
//  Created by Importants on 1/14/25.
//

import AuthenticationServices
import Foundation
import KakaoSDKAuth


public protocol LoginResponseDTO {}

public struct AppleLoginResponseDTO: LoginResponseDTO {
    var credential: ASAuthorizationAppleIDCredential
}

public struct KakaoLoginResponseDTO: LoginResponseDTO {
    var oauthToken: OAuthToken
}

public struct LoginDTO {
    var nonce: String
    var response: LoginResponseDTO
    
    init(
        nonce: String,
        response: LoginResponseDTO
    ) {
        self.nonce = nonce
        self.response = response
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
