//
//  Map.swift
//  Eventers
//
//  Created by Vladislav Erchik on 8/7/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import Foundation
import ComposableArchitecture

struct MapState: Equatable {
    
}

enum MapAction: Equatable {
    
}

struct MapEnvironment {
    
}

let mapReducer = Reducer<MapState, MapAction, MapEnvironment> { state, action, environment in
    .none
}
