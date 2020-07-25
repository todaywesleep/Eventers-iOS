//
//  MainView.swift
//  Eventers
//
//  Created by Vladislav Erchik on 7/18/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct MainView: View {
    let store: Store<MainState, MainAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationStackView(navigationStack: mainNavigationStack) {
                TabView {
                    Text("User screen content")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .tabItem {
                            Text("User")
                        }
                    
                    Text("Map screen content")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .tabItem {
                            Text("Map")
                        }
                    
                    Text("Hub screen content")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .tabItem {
                            Text("Hub")
                        }
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store<MainState, MainAction>(
            initialState: .init(),
            reducer: mainReducer,
            environment: .init()
        )
        
        return MainView(store: store)
    }
}
