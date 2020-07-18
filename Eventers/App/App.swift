//
//  App.swift
//  Eventers
//
//  Created by Vladislav Erchik on 7/17/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import Foundation
import ComposableArchitecture

let appNavigationStack = NavigationStack(easing: .default)

struct AppState: Equatable {
    
}

enum AppAction: Equatable {
    case login
}

struct AppEnvironment {
    
}

let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, _ in
    switch action {
    case .login:
        let authStore = Store<AuthState, AuthAction>(
            initialState: .clear,
            reducer: authReducer,
            environment: .init(parentNavigation: appNavigationStack)
        )
        
        let authView = AuthView(store: authStore)
        
        appNavigationStack.push(authView)
    }
    
    return .none
}
