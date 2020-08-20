//
//  CreateEventView.swift
//  Eventers
//
//  Created by Vladislav Erchik on 8/20/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct CreateEventView: View {
    let store: Store<CreateEventState, CreateEventAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            Text("Create event")
        }
    }
}

struct CreateEventView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store<CreateEventState, CreateEventAction>(
            initialState: CreateEventState(),
            reducer: createEventReducer,
            environment: CreateEventEnvironment()
        )
        
        return CreateEventView(store: store)
    }
}
