//
//  Registration.swift
//  Eventers
//
//  Created by Vladislav Erchik on 7/18/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import Foundation
import ComposableArchitecture
import SwiftUI

struct RegistrationState: BaseAuthState {
    var email: String
    var password: String
    var isRegistered = false
    
    var isLoading: Bool
    
    static var clear: RegistrationState {
        RegistrationState(
            email: "",
            password: "",
            isLoading: false
        )
    }
}

enum RegistrationAction: Equatable {
    case emailChanged(String)
    case passwordChanged(String)
    
    case registerResponse(AuthResponse)
    case register
    case registered
    
    case back
}

struct RegistrationEnvironment {
    init(authManager: AuthManager = .init(),
         parentNavigation: NavigationStack) {
        self.authManager = authManager
        self.parentNavigation = parentNavigation
    }
    
    let authManager: AuthManager
    let parentNavigation: NavigationStack
}

let registrationReducer = Reducer<RegistrationState, RegistrationAction, RegistrationEnvironment> { state, action, environment in
    switch action {
    case let .emailChanged(email):
        state.email = email
        
    case let .passwordChanged(password):
        state.password = password
        
    case .register:
        return environment.authManager.register(using: state.email, password: state.password)
            .eraseToEffect()
            .map { response in RegistrationAction.registerResponse(response) }
        
    case let .registerResponse(response):
        switch response {
        case .success:
            return Effect(value: .registered)
        case let .error(error):
            print("[TEST] Registration error: \(error)")
        }
        
    case .back:
        environment.parentNavigation.pop()
        
    case .registered:
        environment.parentNavigation.pop()
    }
    
    return .none
}
