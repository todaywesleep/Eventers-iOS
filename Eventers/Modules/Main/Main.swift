//
//  Main.swift
//  Eventers
//
//  Created by Vladislav Erchik on 7/18/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import Foundation
import ComposableArchitecture
import ComposableCoreLocation

let mainNavigationStack: NavigationStack = .init(easing: .default)
var mainTabNavigation: TabNavigationStack = .init(by: [])

struct MainState: Equatable {
    var tabBarState: TabBarState = .init(activeItem: .map)
    var mapState: MapState = .init()
    var userPageState: UserPageState = .init()
}

enum MainAction: Equatable {
    case tabBarAction(TabBarAction)
    case mapAction(MapAction)
    case userPageAction(UserPageAction)
}

struct MainEnvironment {
    var locationManager: LocationManager
}

let mainReducer: Reducer<MainState, MainAction, MainEnvironment> = .combine(
    tabBarReducer.pullback(
        state: \MainState.tabBarState,
        action: /MainAction.tabBarAction,
        environment: { _ in TabBarEnvironment() }
    ),
    mapReducer.pullback(
        state: \MainState.mapState,
        action: /MainAction.mapAction,
        environment: { environment in MapEnvironment(locationManager: environment.locationManager) }
    ),
    userPageReducer.pullback(
        state: \MainState.userPageState,
        action: /MainAction.userPageAction,
        environment: { _ in UserPageEnvironment() }
    ),
    Reducer { state, action, environment in
        switch action {
        case let .tabBarAction(tabBarAction):
            if case let .buttonTapped(tab) = tabBarAction {
                mainTabNavigation.select(viewIndex: tab.rawValue)
            }
        case .mapAction:
            break
        case let .userPageAction(userPageAction):
            print("[TEST] UserPageAction: \(userPageAction)")
        }
        
        return .none
    }
)
