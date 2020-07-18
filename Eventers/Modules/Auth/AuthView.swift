//
//  AuthView.swift
//  Eventers
//
//  Created by Vladislav Erchik on 7/16/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct AuthView: View {
    let store: Store<AuthState, AuthAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                Text("Logo")
                    .titleFont()
                
                Spacer()
                
                VStack(spacing: 16) {
                    TextField(
                        "Email",
                        text: .init(
                            get: { viewStore.email },
                            set: { email in viewStore.send(.emailChanged(email)) }
                        )
                    ).keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    
                    TextField(
                        "Password",
                        text: .init(
                            get: { viewStore.password },
                            set: { password in viewStore.send(.passwordChanged(password)) }
                        )
                    )
                }.padding()
                
                Spacer()
                
                Button(action: {
                    viewStore.send(.login)
                }) {
                    Text("Login")
                }
                
                Button(action: {
                    viewStore.send(.register)
                }) {
                    Text("Register")
                }
                
                Button(action: {
                    viewStore.send(.back)
                }) {
                    Text("Back")
                }
            }
        }.hiddenNavigationBar()
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store<AuthState, AuthAction>(
            initialState: AuthState.clear,
            reducer: authReducer,
            environment: AuthEnvironment(parentNavigation: .init(easing: .default))
        )
        
        return AuthView(store: store)
    }
}
