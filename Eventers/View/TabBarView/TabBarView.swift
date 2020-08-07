//
//  TabBarView.swift
//  Eventers
//
//  Created by Vladislav Erchik on 8/6/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct TabBarView: View {
    private let activeItemColor: Color = .red
    private let inactiveItemColor: Color = .white
    private let alignmentStyle: VerticalAlignment
    private let store: Store<TabBarState, TabBarAction>
    
    init(alignmentStyle: VerticalAlignment = .top, store: Store<TabBarState, TabBarAction>) {
        self.store = store
        self.alignmentStyle = alignmentStyle
    }
    
    var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                RectangleGapView(circleRadius: 14)
                
                VStack {
                    Button.init(action: {
                        viewStore.send(TabBarAction.fabTapped)
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.black)
                    }.offset(x: 0, y: -14)
                    
                    Spacer()
                }
                
                HStack(alignment: .top) {
                    Button(action: {
                        viewStore.send(TabBarAction.buttonTapped(.user))
                    }) {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(
                                viewStore.activeItem == TabBarItem.user ? self.activeItemColor : self.inactiveItemColor
                            )
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    
                    Spacer().frame(maxHeight: .infinity)
                    
                    Button(action: {
                        viewStore.send(TabBarAction.buttonTapped(.settings))
                    }) {
                        Image(systemName: "gear")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(
                                viewStore.activeItem == TabBarItem.settings ? self.activeItemColor : self.inactiveItemColor
                            )
                            .frame(maxWidth: .infinity)
                        .padding()
                    }
                }.frame(maxHeight: .infinity)
            }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store<TabBarState, TabBarAction>(
            initialState: TabBarState(),
            reducer: tabBarReducer,
            environment: TabBarEnvironment()
        )
        
        return TabBarView(store: store).frame(height: 200)
    }
}
