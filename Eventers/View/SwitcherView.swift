//
//  SwitcherView.swift
//  Eventers
//
//  Created by Vladislav Erchik on 7/21/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import SwiftUI
import UIKit

struct BottomBarView: View {
//    var images: [UIImage]
    var images: [String]
    let didSelectItem: (Int) -> Void
    
    var body: some View {
        ZStack {
            HStack {
                ForEach(0..<self.images.count) { imageIdx in
                    HStack {
                        Button(action: {
                            self.didSelectItem(imageIdx)
                        }) {
                            Text(self.images[imageIdx])
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
            }.padding()
            
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

struct SwitcherView_Previews: PreviewProvider {
    static var previews: some View {
        return BottomBarView(images: ["1", "2"], didSelectItem: { _ in })
    }
}
