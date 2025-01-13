//
//  AppleLoginAdapter.swift
//  LoginModuleApp
//
//  Created by Importants on 1/13/25.
//

import Foundation
import AuthenticationServices

final class loginAdapter : LoginAdapterInterface {
    let appleService: AppleLoginServiceInterface
    
    init(adaptee: AppleLoginServiceInterface) {
        self.appleService = adaptee
    }
    
    func handleSignIn(
        type: LoginType
    ) async throws -> LoginModel {
        do {
            let result: LoginDTO
            switch type {
            case .apple:
                result = try await appleService.requestLogin()
            case .kakao:
                result = try await appleService.requestLogin()
            }
            return mapping(dto: result)
        }
        catch {
            print("adapter: \(error)")
            guard let error = error as? LoginError
            else { throw error }
            switch error {
            default: throw error } // TODO: Error 처리 부분
        }
    }
    
    public func mapping(
        dto: LoginDTO
    ) -> LoginModel {
        .init(nonce: dto.nonce, userIdentifier: dto.userIdentifier)
    }
}
