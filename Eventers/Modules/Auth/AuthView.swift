//
//  AuthView.swift
//  Eventers
//
//  Created by Vladislav Erchik on 7/16/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

//struct ContentView0: View {
//    @State var isActive = false
//
//    var body: some View {
//        NavigationView {
//            NavigationLink(
//                destination: ContentView2(rootIsActive: self.$isActive),
//                isActive: self.$isActive
//            ) {
//                Text("Hello, World!")
//            }
//            .navigationBarTitle("Root")
//        }
//    }
//}
//
//struct ContentView2: View {
//    @Binding var rootIsActive : Bool
//
//    var body: some View {
//        NavigationLink(destination: ContentView3(shouldPopToRootView: self.$rootIsActive)) {
//            Text("Hello, World #2!")
//        }
//        .navigationBarTitle("Two")
//    }
//}
//
//struct ContentView3: View {
//    @Binding var shouldPopToRootView : Bool
//
//    var body: some View {
//        VStack {
//            Text("Hello, World #3!")
//            Button (action: { self.shouldPopToRootView = false } ){
//                Text("Pop to root")
//            }
//        }.navigationBarTitle("Three")
//    }
//}

struct AuthView: View {
    let store = Store<AuthState, AuthAction>(
        initialState: AuthState.empty,
        reducer: authReducer,
        environment: .init()
    )
    
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
                    )
                    
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
                
                PopButton {
                    Text("Back")
                }
            }
        }.hideNavigationBar()
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
