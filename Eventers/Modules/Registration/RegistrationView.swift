//
//  RegistrationView.swift
//  Eventers
//
//  Created by Vladislav Erchik on 7/18/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct RegistrationView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let store: Store<RegistrationState, RegistrationAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                Text("Registration")
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
                    viewStore.send(.register)
                }) {
                    Text("Register")
                }
                
                PopButton {
                    Text("Back")
                }.padding(.top)
            }.hiddenNavigationBar()
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store<RegistrationState, RegistrationAction>(
            initialState: .clear,
            reducer: registrationReducer,
            environment: .init()
        )
        
        return RegistrationView(store: store)
    }
}
