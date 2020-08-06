//
//  Main.swift
//  Eventers
//
//  Created by Vladislav Erchik on 7/18/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import Foundation
import ComposableArchitecture

let mainNavigationStack = NavigationStack(easing: .default)

struct MainState: Equatable {
    var tabBarState: TabBarState = .init(activeItem: .none)
}

enum MainAction: Equatable {
    case tabBarAction(TabBarAction)
}

struct MainEnvironment {
    
}

let mainReducer: Reducer<MainState, MainAction, MainEnvironment> = .combine(
    tabBarReducer.pullback(
        state: \MainState.tabBarState,
        action: /MainAction.tabBarAction,
        environment: { _ in TabBarEnvironment() }
    ),
    Reducer { state, action, environment in
        switch action {
        case .tabBarAction:
            break
        }
        
        return .none
    }
)
