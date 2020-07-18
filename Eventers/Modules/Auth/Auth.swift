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
        break
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
    }
    
    return .none
}
