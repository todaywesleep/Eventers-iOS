//
//  TabBar.swift
//  Eventers
//
//  Created by Vladislav Erchik on 8/6/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import Foundation
import ComposableArchitecture

enum TabBarItem: Int {
    case user
    case map
    case settings
}

struct TabBarState: Equatable {
    var activeItem: TabBarItem = .map
}

enum TabBarAction: Equatable {
    case buttonTapped(_ type: TabBarItem)
    case fabTapped
}

struct TabBarEnvironment {
    
}

let tabBarReducer = Reducer<TabBarState, TabBarAction, TabBarEnvironment> { state, action, environment in
    switch action {
    case let .buttonTapped(buttonType):
        state.activeItem = buttonType
        print("[TEST] New active: \(buttonType)")
    case .fabTapped:
        break
    }
    
    return .none
}
