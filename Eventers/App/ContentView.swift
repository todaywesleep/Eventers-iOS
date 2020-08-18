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
            Group {
                    NavigationStackView(navigationStack: appNavigationStack) {
                        VStack {
                            Text("Splash screen")
                                .titleFont()
                            
                            Spacer()
                            
                            Button(action: {
                                let authStore = self.store.scope(
                                    state: \.authState,
                                    action: AppAction.authAction
                                )
                                
                                let authView = AuthView(store: authStore)
                                appNavigationStack.push(authView)
                            }) {
                                Text("Authorize")
                                    .foregroundColor(.blue)
                            }
                            
                            Spacer()
                        }
                    }
            }.onAppear {
                if !viewStore.state.isAuthorized {
                    viewStore.send(.authAction(.loginResponse(.success(.done))))
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store<AppState, AppAction>(
            initialState: AppState(),
            reducer: appReducer,
            environment: AppEnvironment(locationManager: .mock())
        )
        
        return ContentView(store: store)
    }
}
