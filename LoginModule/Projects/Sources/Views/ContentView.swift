//
//  ContentView.swift
//  LoginModuleApp
//
//  Created by Importants on 1/13/25.
//

import AuthenticationServices
import SwiftUI

struct LoginView: View {
    let container: AppDIContainer
    @StateObject var viewModel: LoginViewModel
    
    init(
        container: AppDIContainer
    ) {
        self.container = container
        self._viewModel = StateObject(wrappedValue: container.getLoginViewModel())
    }
    
    var body: some View {
        VStack(spacing: 24) {
            VStack(alignment: .leading, spacing: 12) {
                Text("ID: \(viewModel.id)")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity)
                Text("Nonce: \(viewModel.nonce)")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 20)
            LoginButton(background: .black) {
                viewModel.appleLoginButtonTapped()
            } content: {
                HStack(spacing: 4) {
                    Text("")
                    Text("Apple로 로그인")
                }
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.white)
            }
            
            LoginButton(
                background: Color(red: 254/255, green: 229/255, blue: 0/255)
            ) {
                viewModel.kakaoLoginButtonTapped()
            } content: {
                HStack(spacing: 4) {
                    Rectangle()
                        .frame(width: 10, height: 8)
                        .clipShape(.capsule)
                    Text("Kakao로 로그인")
                }
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.black)
            }
        }
    }
}

final class LoginViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var isAuthenticated = false
    @Published var id: String = ""
    @Published var nonce: String = ""
    var loginAdapter: LoginAdapterInterface
    
    init(loginAdapter: LoginAdapterInterface) {
        self.loginAdapter = loginAdapter
    }
    
    public func appleLoginButtonTapped() {
        isLoading = true
        Task {
            do {
                let result = try await loginAdapter.handleSignIn(type: .apple)
                await MainActor.run {
                    id = result.userIdentifier
                    nonce = result.nonce
                    isLoading = false
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    public func kakaoLoginButtonTapped() {
        isLoading = true
        Task {
            do {
                let result = try await loginAdapter.handleSignIn(type: .kakao)
                await MainActor.run {
                    id = result.userIdentifier
                    nonce = result.nonce
                    isLoading = false
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
