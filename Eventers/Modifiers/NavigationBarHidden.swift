//
//  NavigationBarHidden.swift
//  Eventers
//
//  Created by Vladislav Erchik on 7/16/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import SwiftUI

private struct WithoutNavigationBar: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
}

extension View {
    func hideNavigationBar() -> some View {
        self.modifier(WithoutNavigationBar())
    }
}
