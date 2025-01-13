//
//  AppleLoginAdaptee.swift
//  LoginModuleApp
//
//  Created by Importants on 1/14/25.
//

import Foundation
import AuthenticationServices

public protocol AppleLoginServiceInterface {
    func requestLogin() async throws -> LoginDTO
}


final class AppleLoginService: NSObject, AppleLoginServiceInterface {
    @Published var isAuthenticated = false
    @Published var userID: String = ""
    @Published var email: String = ""
    @Published var fullName: String = ""
    
    var continuation: CheckedContinuation<LoginDTO, Error>?
    var nonce: String?
    
    override init() {
        super.init()
    }
    
    public func requestLogin() async throws -> LoginDTO {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        nonce = generateNonce()
        request.nonce = self.nonce
        
        let controller = ASAuthorizationController(
            authorizationRequests: [request]
        )
        
        controller.delegate = self
        controller.performRequests()
        
        return try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation
        }
    }
    
    private func generateNonce() -> String {
        
        // 초기 설정
          let length = 32
          let charset: [Character] = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
          var result = ""
          var remainingLength = length
          
        
        // 난수 생성
          while remainingLength > 0 {
              let randoms: [UInt8] = (0 ..< 16).map { _ in
                  var random: UInt8 = 0
                  let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                  if errorCode != errSecSuccess {
                      fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                  }
                  return random
              }
              
              randoms.forEach { random in
                  if remainingLength == 0 {
                      return
                  }
                  
                  if random < charset.count {
                      result.append(charset[Int(random)])
                      remainingLength -= 1
                  }
              }
          }
          return result
      }
}

extension AppleLoginService: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: any Error) {
        print("Sign in with Apple failed: \n \(error.localizedDescription)")
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential
        else { return }
        
        let userIdentifier = appleIDCredential.user
        let fullName = appleIDCredential.fullName
        let email = appleIDCredential.email
        
        print(userIdentifier, fullName, email)
        guard let continuation
        else { return }
        
        guard let nonce = nonce
        else {
            self.continuation?.resume(
                throwing: LoginError.invalidNonce
            )
            return
        }
        continuation.resume(
            returning: .init(
                nonce: nonce,
                userIdentifier: userIdentifier
            )
        )
    }
}
