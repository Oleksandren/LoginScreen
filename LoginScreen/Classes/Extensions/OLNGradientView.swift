//
//  OLNGradientView.swift
//  LoginScreen
//
//  Created by Oleksandr Nechet on 09.11.15.
//  Copyright © 2015 Oleksandr Nechet. All rights reserved.
//

import UIKit
@IBDesignable
class OLNGradientView: UIView {
    @IBInspectable var topColor: UIColor = UIColor.black
    @IBInspectable var bottomColor: UIColor = UIColor.clear
    
    override func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        let colors = [topColor.cgColor, bottomColor.cgColor]
        let locations: [CGFloat] = [0.0, 1.0]
        let colorspace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorsSpace: colorspace, colors: colors as CFArray, locations: locations)
        let startPoint : CGPoint = CGPoint(x: rect.width/2.0, y: 0)
        let endPoint : CGPoint = CGPoint(x: rect.width/2.0,y: rect.height)
        ctx?.drawLinearGradient(gradient!,start: startPoint, end: endPoint, options: .drawsBeforeStartLocation);
    }
}
