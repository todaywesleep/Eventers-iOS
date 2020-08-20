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
import Combine

let mainNavigationStack: NavigationStack = .init(easing: .default)
var mainTabNavigation: TabNavigationStack = .init(by: [])

enum MainViewMode {
    case normal
    case createModal
}

struct MainState: Equatable {
    var tabBarState: TabBarState = .init(activeItem: .map)
    var mapState: MapState = .init()
    var userPageState: UserPageState = .init()
    
    var viewMode: MainViewMode = .normal
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
            return processTabBarAction(state: &state, action: tabBarAction)
        case .mapAction:
            break
        case let .userPageAction(userPageAction):
            print("[TEST] UserPageAction: \(userPageAction)")
        }
        
        return .none
    }
)

private func processTabBarAction(state: inout MainState, action: TabBarAction) -> Effect<MainAction, Never> {
    switch action {
    case let .buttonTapped(tabBarItem):
        mainTabNavigation.select(viewIndex: tabBarItem.rawValue)
    case .fabTapped:
        state.viewMode = state.viewMode == MainViewMode.normal ? .createModal : .normal
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            mainTabNavigation.select(viewIndex: TabBarItem.map.rawValue)
        }
    case .replaceFabImage:
        break
    }
    
    return .none
}
