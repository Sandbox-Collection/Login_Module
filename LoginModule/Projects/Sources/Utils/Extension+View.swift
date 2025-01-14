//
//  Extension+View.swift
//  LoginModuleApp
//
//  Created by Importants on 1/13/25.
//

import SwiftUI

extension View {
    
}

struct LoginButton<Content: View>: View {
    let background: Color
    let action: () -> Void
    let content: Content
    
    init(
        background: Color = .black,
        action: @escaping () -> Void,
        @ViewBuilder content: () -> Content
        
    ) {
        self.background = background
        self.action = action
        self.content = content()
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            content
                .modifier(
                    LoginFrameModifier(
                        background: background
                    )
                )
        }
    }// 254 229 0
}

struct LoginFrameModifier: ViewModifier {
    var background: Color
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 32)
            .padding(.vertical, 12)
            .background(background)
            .clipShape(.capsule)
    }
}
