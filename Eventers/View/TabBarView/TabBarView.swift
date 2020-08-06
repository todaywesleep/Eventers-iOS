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
    private let activeItemColor: Color = .white
    private let inactiveItemColor: Color = .red
    let store: Store<TabBarState, TabBarAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                RectangleGapView(circleRadius: 14)
                    .frame(height: 48)
                
                Button.init(action: {
                    viewStore.send(TabBarAction.buttonTapped(.add))
                }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.black)
                }.padding(.bottom, 32)
                
                
                HStack {
                    Button(action: {
                        viewStore.send(TabBarAction.buttonTapped(.user))
                    }) {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(
                                viewStore.activeItem == TabBarItem.user ? self.activeItemColor : self.inactiveItemColor
                            )
                    }.frame(maxWidth: .infinity)
                    .padding(.trailing, 14)
                    
                    Spacer()
                    
                    Button(action: {
                        viewStore.send(TabBarAction.buttonTapped(.settings))
                    }) {
                        Image(systemName: "gear")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(
                                viewStore.activeItem == TabBarItem.user ? self.activeItemColor : self.inactiveItemColor
                            )
                    }.frame(maxWidth: .infinity)
                    .padding(.leading, 14)
                }
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
        
        return TabBarView(store: store)
    }
}
