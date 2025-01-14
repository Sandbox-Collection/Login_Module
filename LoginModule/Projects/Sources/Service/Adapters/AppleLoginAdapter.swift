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
    let kakaoService: KakaoLoginServiceInterface
    
    init(
        appleAdaptee: AppleLoginServiceInterface,
        kakaoAdaptee: KakaoLoginServiceInterface
    ) {
        self.appleService = appleAdaptee
        self.kakaoService = kakaoAdaptee
    }
    
    func handleSignIn(
        type: LoginType
    ) async throws -> LoginEntity {
        do {
            // TODO: 로그인 상태 확인
            
            let result: LoginDTO
            switch type {
            case .apple:
                result = try await appleService.requestLogin()
            case .kakao:
                result = try await kakaoService.requestLogin()
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
    ) -> LoginEntity {
        if let response = dto.response as? KakaoLoginResponseDTO {
            return .init(nonce: dto.nonce, userIdentifier: response.oauthToken.accessToken)
        }
        else if let response = dto.response as? AppleLoginResponseDTO {
            return .init(nonce: dto.nonce, userIdentifier: response.credential.user)
        }
        else {
            fatalError("Invalid LoginDTO response")
        }
    }
}
