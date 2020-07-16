//
//  FontTitleModifier.swift
//  Eventers
//
//  Created by Vladislav Erchik on 7/16/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import Foundation
import SwiftUI

private struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .padding()
    }
}

extension View {
    func titleFont() -> some View {
        self.modifier(Title())
    }
}
