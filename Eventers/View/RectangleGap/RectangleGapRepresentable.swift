//
//  RectangleGapRepresentable.swift
//  Eventers
//
//  Created by Vladislav Erchik on 7/25/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct RectangleGapView: UIViewRepresentable {
    private var circleRadius: CGFloat
    
    init(circleRadius: CGFloat = 75) {
        self.circleRadius = circleRadius
    }
    
    func makeUIView(context: Context) -> RectangleGap {
        let rectangleGapView = RectangleGap(circleRadius: circleRadius)
        
        return rectangleGapView
    }
    
    func updateUIView(_ uiView: RectangleGap, context: Context) {
        uiView.layoutIfNeeded()
    }
}

struct RectangleGapView_Previews: PreviewProvider {
    static var previews: some View {
        RectangleGapView(circleRadius: 50)
            .frame(width: UIScreen.main.bounds.width, height: 80)
    }
}

class RectangleGap: UIView {
    private var circleRadius: CGFloat = 50
    private let circleOffset: CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        assembleView()
    }
    
    init(circleRadius: CGFloat) {
        self.circleRadius = circleRadius
        super.init(frame: .zero)
        sizeToFit()
        assembleView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        assembleView()
    }
    
    private func assembleView() {
        if !(layer.sublayers?.isEmpty ?? true) {
            layer.sublayers?.removeAll()
        }
        
        let viewSize = layer.frame.size
        
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: 0, y: 0))
        linePath.addLine(to: CGPoint(x: 0, y: viewSize.height))
        linePath.addLine(to: CGPoint(x: viewSize.width, y: viewSize.height))
        linePath.addLine(to: CGPoint(x: viewSize.width, y: 0))
        linePath.addLine(to: CGPoint(x: viewSize.width / 2 + circleRadius + circleOffset * 2, y: 0))
        linePath.addArc(
            withCenter: CGPoint(x: viewSize.width / 2 + circleRadius + circleOffset * 2, y: circleOffset),
            radius: circleOffset,
            startAngle: 3 / 2 * .pi,
            endAngle: .pi,
            clockwise: false
        )
        linePath.addArc(
            withCenter: CGPoint(x: viewSize.width / 2, y: circleOffset),
            radius: circleRadius + circleOffset,
            startAngle: .pi * 2,
            endAngle: .pi,
            clockwise: true
        )
        linePath.addArc(
            withCenter: CGPoint(x: viewSize.width / 2 - circleRadius - circleOffset * 2, y: circleOffset),
            radius: circleOffset,
            startAngle: .pi * 2,
            endAngle: 3 / 2 * .pi,
            clockwise: false
        )
        linePath.addLine(to: CGPoint(x: 0, y: 0))

        let fillLayer = CAShapeLayer()
        fillLayer.lineWidth = 3
        fillLayer.path = linePath.cgPath
        fillLayer.fillColor = UIColor.black.cgColor
        fillLayer.strokeColor = UIColor.red.cgColor

        layer.addSublayer(fillLayer)
    }
}
