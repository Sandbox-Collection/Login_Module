//
//  AppDIContainer.swift
//  LoginModule
//
//  Created by 이재훈 on 1/14/25.
//

import Foundation
import KakaoSDKCommon

final class AppDIContainer {
    let manager: AppManager = AppManager()

    init() {}
    
    func getLoginViewModel() -> LoginViewModel {
        let appleAdaptee = AppleLoginService()
        let kakaoAdaptee = KakaoLoginService()
        
        let loginAdapter = loginAdapter(
            appleAdaptee: appleAdaptee,
            kakaoAdaptee: kakaoAdaptee
        )
        
        return LoginViewModel(loginAdapter: loginAdapter)
    }
    
    func getLoginSuccessViewModel() -> LoginSuccessViewModel {
        return LoginSuccessViewModel()
    }
    
}

extension AppDIContainer {
    func didFinishLaunchingWithOptions() {
        manager.handleApp()
    }
    
    func didRegisterForRemoteNotificationsWithDeviceToken() {
        
    }
    
    func didFailToRegisterForRemoteNotificationsWithError() {
        
    }
}

final class AppManager {
    func handleApp() {
        KakaoSDK.initSDK(appKey: Environment.kakaoKey)
    }
    
    func getToken() {
        
    }
    
    func didFailToRegisterForRemoteNotificationsWithError() {
        
    }
}
