//
//  LoginSuccessView.swift
//  LoginModule
//
//  Created by 이재훈 on 1/14/25.
//

import SwiftUI

struct LoginSuccessView: View {
    let container: AppDIContainer
    @StateObject var viewModel: LoginSuccessViewModel
    
    init(container: AppDIContainer, viewModel: LoginSuccessViewModel) {
        self.container = container
        self._viewModel = StateObject(wrappedValue: container.getLoginSuccessViewModel())
    }
    
    var body: some View {
        Text(viewModel.isToggle ? "Login Success" : "Login ??")
    }
}


final class LoginSuccessViewModel: ObservableObject {
    @Published var isToggle = false
    
    func buttonTapped() {
        isToggle.toggle()
    }
}
