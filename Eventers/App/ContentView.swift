//
//  ContentView.swift
//  Eventers
//
//  Created by Vladislav Erchik on 7/16/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    let store: Store<AppState, AppAction>
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Splash screen")
                    .titleFont()
                
                Spacer()
                
                NavigationLink(destination: AuthView()) {
                    Text("Authorize")
                }
                
                Spacer()
            }.hiddenNavigationBar()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store<AppState, AppAction>(
            initialState: AppState(),
            reducer: appReducer,
            environment: AppEnvironment()
        )
        
        return ContentView(store: store)
    }
}
