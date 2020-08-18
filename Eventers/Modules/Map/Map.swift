//
//  Map.swift
//  Eventers
//
//  Created by Vladislav Erchik on 8/7/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import Foundation
import ComposableArchitecture
import ComposableCoreLocation

struct MapState: Equatable {
    
}

enum MapAction: Equatable {
    case locationManager(LocationManager.Action)
}

struct MapEnvironment {
    var locationManager: LocationManager
}

let mapReducer = Reducer<MapState, MapAction, MapEnvironment> { state, action, environment in
    switch action {
    case let .locationManager(locationAction):
        return handleLocationAction(state: &state, action: locationAction)
    }
}

private func handleLocationAction(state: inout MapState, action: LocationManager.Action) -> Effect<MapAction, Never> {
    
    
    return .none
}
