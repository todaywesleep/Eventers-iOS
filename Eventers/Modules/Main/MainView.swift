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
    
    init(store: Store<MainState, MainAction>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                TabNavigationView(
                    views: [
                        Text("User view")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.white)
                            .wrapped,
                        
                        MapView(
                            store: self.store.scope(
                                state: \.mapState,
                                action: MainAction.mapAction
                            )
                        ).frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.white)
                        .wrapped,
                        
                        Text("Settings view")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.white)
                            .wrapped
                    ],
                    stack: &mainTabNavigation,
                    activeItem: viewStore.tabBarState.activeItem.rawValue
                )
                
                TabBarView(
                    alignmentStyle: .top,
                    store: self.store.scope(
                        state: \.tabBarState,
                        action: MainAction.tabBarAction
                    )
                ).frame(height: 80)
            }
        }.edgesIgnoringSafeArea(.bottom)
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
