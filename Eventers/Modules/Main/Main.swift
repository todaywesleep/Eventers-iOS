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
    
}

enum MainAction: Equatable {
    
}

struct MainEnvironment {
    
}

let mainReducer = Reducer<MainState, MainAction, MainEnvironment> { state, action, environment in
    .none
}
