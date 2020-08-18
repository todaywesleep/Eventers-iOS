//
//  MapView.swift
//  Eventers
//
//  Created by Vladislav Erchik on 8/7/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import MapKit
import ComposableCoreLocation

struct MapView: View {
    let store: Store<MapState, MapAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            Text("Here may be mapView")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store<MapState, MapAction>(
            initialState: MapState(),
            reducer: mapReducer,
            environment: MapEnvironment(locationManager: .mock())
        )
        
        return MapView(store: store)
    }
}
