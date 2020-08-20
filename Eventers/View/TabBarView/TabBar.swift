//
//  TabBar.swift
//  Eventers
//
//  Created by Vladislav Erchik on 8/6/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import Foundation
import ComposableArchitecture
import SwiftUI

enum TabBarItem: Int {
    case user
    case map
    case settings
}

struct TabBarState: Equatable {
    var activeItem: TabBarItem = .map
    
    var favIconSystemName: String = "plus"
}

enum TabBarAction: Equatable {
    case buttonTapped(_ type: TabBarItem)
    case replaceFabImage(_ systemName: String)
    case fabTapped
}

struct TabBarEnvironment {
    
}

let tabBarReducer = Reducer<TabBarState, TabBarAction, TabBarEnvironment> { state, action, environment in
    switch action {
    case let .buttonTapped(buttonType):
        state.activeItem = buttonType
        
        let newTabBarImage = buttonType == .map ? "plus.circle.fill" : "map"
        return Effect(value: TabBarAction.replaceFabImage(newTabBarImage))
    case let .replaceFabImage(systemName):
        state.favIconSystemName = systemName
    case .fabTapped:
        break
    }
    
    return .none
}
