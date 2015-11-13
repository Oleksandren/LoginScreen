//
//  OLNThinTextField.swift
//  LoginScreen
//
//  Created by Oleksandr Nechet on 09.11.15.
//  Copyright © 2015 Oleksandr Nechet. All rights reserved.
//

import UIKit

class OLNThinTextField: UITextField {
    @IBInspectable var separatorColor = UIColor.lightGrayColor()
    @IBInspectable var placeholderColor: UIColor = UIColor.whiteColor()
    @IBInspectable var placeholderAligment: NSTextAlignment = NSTextAlignment.Center
    override func drawRect(rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(ctx, 1)
        CGContextSetStrokeColorWithColor(ctx, separatorColor.CGColor)
        CGContextMoveToPoint(ctx, 0, rect.size.height)
        CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height)
        CGContextStrokePath(ctx)
    }
    
    override func drawPlaceholderInRect(rect: CGRect) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = placeholderAligment
        let textFontAttributes = [
            NSFontAttributeName: self.font!,
            NSForegroundColorAttributeName: placeholderColor,
            NSParagraphStyleAttributeName: paragraphStyle,
        ]
        placeholder!.drawInRect(rect, withAttributes: textFontAttributes)
    }    
}
