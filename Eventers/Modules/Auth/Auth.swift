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
    var registrationState = RegistrationState.clear
    
    static var clear: AuthState {
        AuthState(
            email: "",
            password: "",
            isLoading: false
        )
    }
}

enum AuthAction: Equatable {
    case registrationAction(RegistrationAction)
    
    case emailChanged(String)
    case passwordChanged(String)
    
    case login
    case loginResponse(Result<AuthResponse, AuthError>)
    case loginSuccessful
    case error(String)
    
    case back
}

struct AuthEnvironment {
    let parentNavigation: NavigationStack
    
    init (parentNavigation: NavigationStack) {
        self.parentNavigation = parentNavigation
    }
}

let authReducer = Reducer<AuthState, AuthAction, AuthEnvironment>.combine(
    registrationReducer.pullback(
        state: \AuthState.registrationState,
        action: /AuthAction.registrationAction,
        environment: { environment in RegistrationEnvironment(parentNavigation: environment.parentNavigation) }
    ),
    Reducer { state, action, environment in
        switch action {
        case let .emailChanged(email):
            state.email = email
        case let .passwordChanged(password):
            state.password = password
        case .login:
            return apiManager.auth.authorize(using: state.email, password: state.password)
                .catchToEffect()
                .map { result in AuthAction.loginResponse(result) }
        case .back:
            environment.parentNavigation.pop()
        case let .loginResponse(response):
            return handleLoginResponse(response: response, state: &state)
        case let .error(text):
            print("[TEST] Error: \(text)")
        case .loginSuccessful:
            break
        case .registrationAction:
            break
        }
        
        return .none
    }
)

private func handleLoginResponse(response: Result<AuthResponse, AuthError>, state: inout AuthState) -> Effect<AuthAction, Never> {
    switch response {
    case let .failure(error):
        print("[TEST] Error: \(error.localizedDescription)")
    case .success(_):
        return Effect(value: AuthAction.loginSuccessful)
    }
    
    return .none
}
