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
        WithViewStore(store) { viewStore in
            if !viewStore.state.isAuthorized {
                NavigationStackView(navigationStack: appNavigationStack) {
                    VStack {
                        Text("Splash screen")
                            .titleFont()
                        
                        Spacer()
                        
                        Button(action: {
                            viewStore.send(.login)
                        }) {
                            Text("Authorize")
                                .foregroundColor(.blue)
                        }
                        
                        Spacer()
                    }
                }
            } else {
                MainView(
                    store: self.store.scope(
                        state: \.mainState,
                        action: AppAction.mainAction
                    )
                ).frame(maxWidth: .infinity, maxHeight: .infinity)
            }
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
