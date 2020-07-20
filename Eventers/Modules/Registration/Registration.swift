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
    var name: String
    var lastName: String
    var phone: String
    
    var isLoading: Bool
    
    static var clear: RegistrationState {
        RegistrationState(
            email: "",
            password: "",
            name: "",
            lastName: "",
            phone: "",
            isLoading: false
        )
    }
}

enum RegistrationAction: Equatable {
    case emailChanged(String)
    case passwordChanged(String)
    case nameChanged(String)
    case lastNameChanged(String)
    case phoneChanged(String)
    
    case registrationResponse(Result<AuthResponse, AuthError>)
    case register
    case registered
    
    case back
}

struct RegistrationEnvironment {
    init(parentNavigation: NavigationStack) {
        self.parentNavigation = parentNavigation
    }
    
    let parentNavigation: NavigationStack
}

let registrationReducer = Reducer<RegistrationState, RegistrationAction, RegistrationEnvironment> { state, action, environment in
    switch action {
    case let .emailChanged(email):
        state.email = email
        
    case let .passwordChanged(password):
        state.password = password
        
    case let .nameChanged(name):
        state.name = name
        
    case let .lastNameChanged(lastName):
        state.lastName = lastName
        
    case let .phoneChanged(phone):
        state.phone = phone
        
    case .register:
        let userModel = UserModel(
            email: state.email,
            name: state.name,
            lastName: state.lastName,
            phone: state.phone
        )
        
        return apiManager.auth.register(password: state.password, userModel: userModel)
            .catchToEffect()
            .map { response in RegistrationAction.registrationResponse(response) }
        
    case let .registrationResponse(response):
        switch response {
        case let .success(result):
            return Effect(value: .registered)
        case let .failure(error):
            print("[TEST] Registration error: \(error)")
        }
        
    case .back:
        environment.parentNavigation.pop()
        
    case .registered:
        environment.parentNavigation.pop()
    }
    
    return .none
}
