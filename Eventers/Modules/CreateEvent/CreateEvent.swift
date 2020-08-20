//
//  CreateEvent.swift
//  Eventers
//
//  Created by Vladislav Erchik on 8/20/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import Foundation
import ComposableArchitecture

struct CreateEventState: Equatable {
    
}

enum CreateEventAction: Equatable {
    
}

struct CreateEventEnvironment {
    
}

let createEventReducer = Reducer<CreateEventState, CreateEventAction, CreateEventEnvironment> { state, action, environment in
    .none
}
