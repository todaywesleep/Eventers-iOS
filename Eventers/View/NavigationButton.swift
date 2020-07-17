//
//  NavigationButton.swift
//  Eventers
//
//  Created by Vladislav Erchik on 7/16/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import SwiftUI

struct PopButton<Label>: View where Label: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var content: () -> Label
    
    var body: some View {
        Button(action: {
            self.mode.wrappedValue.dismiss()
        }) {
            content()
        }
    }
}

struct NavigationButton_Previews: PreviewProvider {
    static var previews: some View {
        PopButton() {
            Text("Pop button")
        }
    }
}
