//
//  OLNLogoView.swift
//  LoginScreen
//
//  Created by Oleksandr Nechet on 10.11.15.
//  Copyright © 2015 Oleksandr Nechet. All rights reserved.
//

import UIKit

@IBDesignable
class OLNLogoView: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let w = rect.width
        let h = rect.height
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.setLineWidth(1)
        ctx.setStrokeColor(UIColor.white.cgColor)
        ctx.addArc(center: CGPoint(x: w/2, y: h/2),
                   radius: min(w/2, h/2),
                   startAngle: CGFloat(Float(M_PI) * 0.6),
                   endAngle: -CGFloat(Float(M_PI) * 0.6),
                   clockwise: false)
        ctx.addArc(center: CGPoint(x: w/2, y: h/2),
                   radius: min(w/2, h/2),
                   startAngle: CGFloat(Float(M_PI) * 0.4),
                   endAngle: -CGFloat(Float(M_PI) * 0.4),
                   clockwise: true)
        ctx.strokePath()
    }
}
