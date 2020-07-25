//
//  RectangleGapRepresentable.swift
//  Eventers
//
//  Created by Vladislav Erchik on 7/25/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import Foundation
import UIKit

class RectangleGapRepresentable: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        assembleView()
    }
    
    init() {
        super.init(frame: .zero)
        assembleView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func assembleView() {
        let rect = CGSize(width: 50, height: 50)
        
        let radius: CGFloat = rect.width
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height), cornerRadius: 0)
        let circlePath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 2 * radius, height: 2 * radius), cornerRadius: radius)
        path.append(circlePath)
        path.usesEvenOddFillRule = true

        let fillLayer = CAShapeLayer()
        fillLayer.path = path.cgPath
        fillLayer.fillRule = .evenOdd
        fillLayer.fillColor = backgroundColor?.cgColor
        fillLayer.opacity = 0.5
        layer.addSublayer(fillLayer)
    }
}
