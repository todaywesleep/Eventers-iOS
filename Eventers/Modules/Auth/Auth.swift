//
//  Auth.swift
//  Eventers
//
//  Created by Vladislav Erchik on 7/17/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import Foundation
import ComposableArchitecture
import Combine

struct AuthState: BaseAuthState {
    var email: String
    var password: String
    var isLoading: Bool
    
    static var clear: AuthState {
        AuthState(
            email: "",
            password: "",
            isLoading: false
        )
    }
}

enum AuthAction: Equatable {
    case emailChanged(String)
    case passwordChanged(String)
    
    case login
    case loginResponse(AuthResponse)
    case register
    
    case back
}

struct AuthEnvironment {
    let authManager: AuthManager
    let parentNavigation: NavigationStack
    
    init (authManager: AuthManager = .init(),
          parentNavigation: NavigationStack) {
        self.authManager = authManager
        self.parentNavigation = parentNavigation
    }
}

let authReducer = Reducer<AuthState, AuthAction, AuthEnvironment> { state, action, environment in
    switch action {
    case let .emailChanged(email):
        state.email = email
    case let .passwordChanged(password):
        state.password = password
    case .login:
        return environment.authManager.authorize(using: state.email, password: state.password)
            .eraseToEffect()
            .map { response in AuthAction.loginResponse(response) }
    case .register:
        let registrationStore = Store<RegistrationState, RegistrationAction>(
            initialState: .clear,
            reducer: registrationReducer,
            environment: .init(parentNavigation: environment.parentNavigation)
        )
        
        let registrationView = RegistrationView(store: registrationStore)
        
        environment.parentNavigation.push(registrationView)
    case .back:
        environment.parentNavigation.pop()
    case let .loginResponse(response):
        handleLoginResponse(response: response, state: &state, navigation: environment.parentNavigation)
    }
    
    return .none
}

private func handleLoginResponse(response: AuthResponse, state: inout AuthState, navigation: NavigationStack) {
    switch response {
    case let .error(text):
        print("[TEST] Authorization error: \(text)")
    case .success:
        let mainStore = Store<MainState, MainAction>(
            initialState: .init(),
            reducer: mainReducer,
            environment: .init()
        )
        
        let mainView = MainView(store: mainStore)
        
        appNavigationStack.pop(to: .root)
        appNavigationStack.push(mainView)
    }
}
