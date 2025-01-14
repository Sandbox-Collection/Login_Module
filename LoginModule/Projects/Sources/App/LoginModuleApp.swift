//
//  LoginModuleApp.swift
//  LoginModuleApp
//
//  Created by Importants on 1/13/25.
//

import KakaoSDKAuth
import SwiftUI

@main
struct LoginModuleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            LoginView(
                container: appDelegate.container
            )
            .onOpenURL { url in
                print("URL: \(url)")
                if AuthApi.isKakaoTalkLoginUrl(url) {
                    _ = AuthController.handleOpenUrl(url: url)
                }
            }
        }
    }
}
