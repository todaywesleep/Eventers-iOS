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
    
    static var empty: AuthState {
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
}

struct AuthEnvironment {
    let authManager: AuthManager
    
    init (authManager: AuthManager = .init()) {
        self.authManager = authManager
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
    }
    
    return .none
}
