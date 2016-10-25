//
//  OLNThinTextField.swift
//  LoginScreen
//
//  Created by Oleksandr Nechet on 09.11.15.
//  Copyright © 2015 Oleksandr Nechet. All rights reserved.
//

import UIKit

class OLNThinTextField: UITextField {
    @IBInspectable var separatorColor = UIColor.lightGray
    @IBInspectable var placeholderColor: UIColor = UIColor.white
    @IBInspectable var placeholderAligment: NSTextAlignment = NSTextAlignment.center
    override func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.setLineWidth(1)
        ctx?.setStrokeColor(separatorColor.cgColor)
        ctx?.move(to: CGPoint(x: 0, y: rect.size.height))
        ctx?.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height))
        ctx?.strokePath()
    }
    
    override func drawPlaceholder(in rect: CGRect) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = placeholderAligment
        let textFontAttributes = [
            NSFontAttributeName: self.font!,
            NSForegroundColorAttributeName: placeholderColor,
            NSParagraphStyleAttributeName: paragraphStyle,
        ] as [String : Any]
        placeholder!.draw(in: rect, withAttributes: textFontAttributes)
    }    
}
