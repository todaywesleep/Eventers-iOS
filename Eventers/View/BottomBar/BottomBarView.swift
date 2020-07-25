//
//  SwitcherView.swift
//  Eventers
//
//  Created by Vladislav Erchik on 7/21/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import SwiftUI
import UIKit
import ComposableArchitecture

struct BottomBarView: View {
    let store: Store<BottomBarState, BottomBarAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                HStack(spacing: 0) {
                    Button(action: {

                    }) {
                        Spacer()
                        
                        Image(systemName: "person")
                            .resizable()
                            .foregroundColor(Color.red)
                            .frame(width: 40, height: 40)
                        
                        Spacer()
                    }.frame(height: 50)
                    .background(Color.black)
                    
                    
                    Rectangle()
                        .foregroundColor(Color.black)
                        .frame(width: 70, height: 50)
                    
                    Button(action: {

                    }) {
                        Spacer()
                        
                        Image(systemName: "gear")
                            .resizable()
                            .foregroundColor(Color.red)
                            .frame(width: 40, height: 40)
                        
                        Spacer()
                    }.frame(height: 50)
                    .background(Color.black)
                }
                
                HStack {
                    Spacer()
                    
                    Circle().foregroundColor(Color.blue)
                        .frame(width: 56, height: 56)
                        .overlay(Text("+"))
                    
                    Spacer()
                }.offset(x: 0, y: -16)
                
            }.frame(maxWidth: .infinity)
        }
    }
}

struct SwitcherView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store<BottomBarState, BottomBarAction>(
            initialState: .init(),
            reducer: bottomBarReducer,
            environment: .init()
        )
        
        return BottomBarView(store: store)
    }
}
