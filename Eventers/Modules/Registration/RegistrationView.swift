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
                    
                    Rectangle()
                        .frame(maxWidth: .infinity)
                        .frame(height: 10)
                        .foregroundColor(Color.gray)
                    
                    TextField(
                        "Name",
                        text: .init(
                            get: { viewStore.name },
                            set: { name in viewStore.send(.nameChanged(name)) }
                        )
                    )
                    
                    TextField(
                        "Last name",
                        text: .init(
                            get: { viewStore.lastName },
                            set: { lastName in viewStore.send(.lastNameChanged(lastName)) }
                        )
                    )
                    
                    TextField(
                        "Phone",
                        text: .init(
                            get: { viewStore.phone },
                            set: { phone in viewStore.send(.phoneChanged(phone)) }
                        )
                    )
                }.padding()

                Spacer()

                Button(action: {
                    viewStore.send(.register)
                }) {
                    Text("Register")
                }
                
                
                Button(action: {
                    viewStore.send(.back)
                }) {
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
            environment: .init(parentNavigation: .init(easing: .default))
        )
        
        return RegistrationView(store: store)
    }
}
