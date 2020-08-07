//
//  MapView.swift
//  Eventers
//
//  Created by Vladislav Erchik on 8/7/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct MapView: View {
    let store: Store<MapState, MapAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            Text("Here may be mapView")
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store<MapState, MapAction>(
            initialState: MapState(),
            reducer: mapReducer,
            environment: MapEnvironment()
        )
        
        return MapView(store: store)
    }
}
