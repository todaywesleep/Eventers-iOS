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
let apiManager: ApiManagerService = ApiManager(authManager: .init(), userManager: .init())

struct AppState: Equatable {
    var isAuthorized = apiManager.auth.isAuthorized
    var mainState = MainState()
}

enum AppAction: Equatable {
    case mainAction(MainAction)
    
    case login
}

struct AppEnvironment {
    
}

let appReducer: Reducer<AppState, AppAction, AppEnvironment> = .combine(
    mainReducer.pullback(
        state: \AppState.mainState,
        action: /AppAction.mainAction,
        environment: { _ in .init() }
    ),
    Reducer { state, action, _ in
        switch action {
        case .login:
            let authStore = Store<AuthState, AuthAction>(
                initialState: .clear,
                reducer: authReducer,
                environment: .init(parentNavigation: appNavigationStack)
            )
            
            let authView = AuthView(store: authStore)
            
            appNavigationStack.push(authView)
            
        case .mainAction:
            break
        }
        
        return .none
    }
)
