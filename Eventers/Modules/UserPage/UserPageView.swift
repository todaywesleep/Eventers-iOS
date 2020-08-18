//
//  UserPageView.swift
//  Eventers
//
//  Created by Vladislav Erchik on 8/18/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct UserPageView: View {
    let store: Store<UserPageState, UserPageAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            Button(action: {
                viewStore.send(UserPageAction.logout)
            }) {
                Text("Logout")
                    .font(.system(size: 30, weight: .bold))
            }
        }
    }
}

struct UserPageView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store<UserPageState, UserPageAction>(
            initialState: UserPageState(),
            reducer: userPageReducer,
            environment: UserPageEnvironment()
        )
        
        return UserPageView(store: store)
    }
}
