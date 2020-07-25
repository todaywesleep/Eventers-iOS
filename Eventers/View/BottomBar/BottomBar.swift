//
//  BottomBar.swift
//  Eventers
//
//  Created by Vladislav Erchik on 7/25/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import Foundation
import ComposableArchitecture

struct BottomBarState: Equatable {
    
}

enum BottomBarAction: Equatable {
    
}

struct BottomBarEnvironment {
    
}

let bottomBarReducer = Reducer<BottomBarState, BottomBarAction, BottomBarEnvironment> { state, action, _ in
    .none
}
