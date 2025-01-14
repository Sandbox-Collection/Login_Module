//
//  AppDelegate.swift
//  LoginModule
//
//  Created by 이재훈 on 1/14/25.
//

import Foundation
import UIKit

final class AppDelegate: NSObject, UIApplicationDelegate {
    let container = AppDIContainer()
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        container.didFinishLaunchingWithOptions()
        return true
    }
    
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        container.didRegisterForRemoteNotificationsWithDeviceToken()
    }
    
    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
        container.didFailToRegisterForRemoteNotificationsWithError()
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        return false
    }
}

