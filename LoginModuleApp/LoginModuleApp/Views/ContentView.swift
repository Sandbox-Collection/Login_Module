//
//  ContentView.swift
//  LoginModuleApp
//
//  Created by Importants on 1/13/25.
//

import AuthenticationServices
import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = LoginViewModel(
        loginAdapter: loginAdapter(
            adaptee: AppleLoginService()
        )
    )
    
    var body: some View {
        VStack(spacing: 24) {
            VStack(alignment: .leading, spacing: 12) {
                Text("ID: \(viewModel.userID)")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.black)
                
                Text("email: \(viewModel.email)")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.black)
            }
            .frame(maxWidth: .infinity)
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
    @Published var isAuthenticated = false
    @Published var userID: String = ""
    @Published var email: String = ""
    @Published var fullName: String = ""
    var loginAdapter: LoginAdapterInterface
    
    init(loginAdapter: LoginAdapterInterface) {
        self.loginAdapter = loginAdapter
    }

    public func appleLoginButtonTapped() {
        Task {
            do {
                let result = try await loginAdapter.handleSignIn(type: .apple)
                print(result)
            } catch {
                print("??")
                print(error.localizedDescription)
            }
        }
    }
    
    public func kakaoLoginButtonTapped() {
        
    }
}
