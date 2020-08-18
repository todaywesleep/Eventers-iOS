//
//  App.swift
//  Eventers
//
//  Created by Vladislav Erchik on 7/17/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import Foundation
import ComposableArchitecture
import ComposableCoreLocation

struct LocationManagerId: Hashable {}

let appNavigationStack = NavigationStack(easing: .default)
let apiManager: ApiManagerService = ApiManager(authManager: .init(), userManager: .init())

struct AppState: Equatable {
    var isAuthorized = apiManager.auth.isAuthorized
    var mainState = MainState()
    var authState = AuthState.clear
}

enum AppAction: Equatable {
    case mainAction(MainAction)
    case authAction(AuthAction)
    case onAppear
    case locationManager(LocationManager.Action)
}

struct AppEnvironment {
    var locationManager: LocationManager
}

let appReducer: Reducer<AppState, AppAction, AppEnvironment> = .combine(
    mainReducer.pullback(
        state: \AppState.mainState,
        action: /AppAction.mainAction,
        environment: { environment in MainEnvironment(locationManager: environment.locationManager) }
    ),
    authReducer.pullback(
        state: \AppState.authState,
        action: /AppAction.authAction,
        environment: { _ in AuthEnvironment(parentNavigation: appNavigationStack) }
    ),
    Reducer { state, action, environment in
        switch action {
        case .onAppear:
            return .merge(
                environment.locationManager
                    .create(id: LocationManagerId())
                    .map(AppAction.locationManager),
                
                environment.locationManager
                    .requestWhenInUseAuthorization(id: LocationManagerId())
                    .fireAndForget()
            )
        case let .locationManager(managerAction):
            return Effect(value: AppAction.mainAction(.mapAction(.locationManager(managerAction))))
        case let .authAction(loginAction):
            return hangleLoginAction(appState: &state, action: loginAction, environment: environment)
        case .mainAction:
            break
        }
        
        return .none
    }
)

private func hangleLoginAction(appState: inout AppState, action: AuthAction, environment: AppEnvironment) -> Effect<AppAction, Never> {
    switch action {
    case .loginSuccessful:
        let mainView = createMainView(using: environment)
        appNavigationStack.push(mainView)
    case let .registrationAction(registrationAction):
        return handleRegistrationAction(appState: &appState, action: registrationAction, environment: environment)
    default:
        break
    }
    
    return .none
}

private func handleRegistrationAction(appState: inout AppState, action: RegistrationAction, environment: AppEnvironment) -> Effect<AppAction, Never> {
    if action == .registered {
        let mainView = createMainView(using: environment)
        appNavigationStack.push(mainView)
    }
    
    return .none
}

private func createMainView(using environment: AppEnvironment) -> MainView {
    let mainStore = Store<MainState, MainAction>(
        initialState: MainState(),
        reducer: mainReducer,
        environment: MainEnvironment(locationManager: environment.locationManager)
    )

    return MainView(store: mainStore)
}
