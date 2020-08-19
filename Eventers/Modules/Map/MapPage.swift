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

struct MapPage: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    let store: Store<MapState, MapAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            MapView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
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
        
        return MapPage(store: store)
    }
}
