//
//  ContentView.swift
//  Eventers
//
//  Created by Vladislav Erchik on 7/16/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Splash screen")
                    .titleFont()
                
                Spacer()
                
                NavigationLink(destination: AuthView()) {
                    Text("Authorize")
                }
                
                Spacer()
            }.hideNavigationBar()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
