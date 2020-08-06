//
//  TabBar.swift
//  Eventers
//
//  Created by Vladislav Erchik on 8/6/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import Foundation
import ComposableArchitecture

enum TabBarItem {
    case none
    case user
    case add
    case settings
}

struct TabBarState: Equatable {
    var activeItem: TabBarItem = .none
}

enum TabBarAction: Equatable {
    case buttonTapped(_ type: TabBarItem)
}

struct TabBarEnvironment {
    
}

let tabBarReducer = Reducer<TabBarState, TabBarAction, TabBarEnvironment> { state, action, environment in
    switch action {
    case let .buttonTapped(buttonType):
        state.activeItem = buttonType
        print("[TEST] New active: \(buttonType)")
    }
    
    return .none
}
