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
    @IBInspectable var topColor: UIColor = UIColor.blackColor()
    @IBInspectable var bottomColor: UIColor = UIColor.clearColor()
    
    override func drawRect(rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        let colors = [topColor.CGColor, bottomColor.CGColor]
        let locations: [CGFloat] = [0.0, 1.0]
        let colorspace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradientCreateWithColors(colorspace, colors, locations)
        let startPoint : CGPoint = CGPointMake(rect.width/2.0, 0)
        let endPoint : CGPoint = CGPointMake(rect.width/2.0,rect.height)
        CGContextDrawLinearGradient(ctx, gradient,startPoint, endPoint, .DrawsBeforeStartLocation);
    }
}
