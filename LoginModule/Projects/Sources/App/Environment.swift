//
//  Environment.swift
//  LoginModule
//
//  Created by 이재훈 on 1/14/25.
//

import Foundation

public enum Environment {
    enum Keys {
        enum Plist {
            static let KakaoKey = "KAKAO_APP_KEY"
        }
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary
        else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    static let kakaoKey: String = {
        guard let kakaoKey = Environment.infoDictionary[Keys.Plist.KakaoKey] as? String
        else {
            fatalError("Kakao Key not set in plist for this environment")
        }
        return kakaoKey
    }()
}
