//
//  OLNSocialButton.swift
//  LoginScreen
//
//  Created by Oleksandr Nechet on 09.11.15.
//  Copyright © 2015 Oleksandr Nechet. All rights reserved.
//

import UIKit


class OLNSocialButton: UIButton {
    @IBOutlet weak var layoutConstraintWidth: NSLayoutConstraint!
    @IBOutlet weak var layoutConstraintLeadingSpace: NSLayoutConstraint?
    @IBInspectable var expandedSize: CGSize = CGSizeZero
    var expanded = false
    var drawExpandedBackground = false
    var initialFrame: CGRect!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialFrame = self.frame
    }
    
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        var imageRect = CGRectZero
        imageRect.size = initialFrame.size
        return imageRect
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        if drawExpandedBackground {
            let context = UIGraphicsGetCurrentContext()
            CGContextSaveGState(context);
            CGContextAddRect(context, CGContextGetClipBoundingBox(context));
            CGContextAddArc(context, 19, 19, 19, 0, CGFloat(Float(M_PI) * 2), 0)
            CGContextClosePath(context);
            CGContextEOClip(context);
            CGContextMoveToPoint(context, 0, 0);
            CGContextAddLineToPoint(context, 168, 0);
            CGContextAddLineToPoint(context, 168, 38);
            CGContextAddLineToPoint(context, 0, 38);
            CGContextAddLineToPoint(context, 0, 0);
            CGContextSetRGBFillColor(context, 0.75, 0.75, 0.75, 0.5);
            CGContextFillPath(context);
            CGContextRestoreGState(context);
        }
    }
    
    func checkSettings() -> Bool {
        if CGSizeEqualToSize(expandedSize, CGSizeZero) {
            print("Expanded Size must be setted in IB")
            return false
        }
        if (layoutConstraintWidth == nil) {
            print("Setup layout Constraint Width for button in IB")
            return false
        }
        return true
    }
    
    func expand () {
        self.layer.removeAllAnimations()
        self.expanded = !self.expanded
        
        if expanded {
            layoutConstraintWidth.constant = expandedSize.width
            self.layoutIfNeeded()
            drawExpandedBackground = true
            self.setNeedsDisplay()
        }
        
        var initialBounds = CGRectZero
        initialBounds.size = initialFrame.size
        let initialCornerRadius = max(CGRectGetHeight(initialBounds), CGRectGetWidth(initialBounds))
        let initialPath = UIBezierPath(roundedRect: initialBounds, cornerRadius: initialCornerRadius).CGPath
        let finalCornerRadius = max(expandedSize.width, expandedSize.height)
        let finalRect = CGRectMake(0, 0, expandedSize.width, expandedSize.height)
        let finalParh  = UIBezierPath(roundedRect: finalRect, cornerRadius: finalCornerRadius).CGPath
        
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = (expanded ? initialPath : finalParh)
        maskLayerAnimation.toValue = (expanded ? finalParh : initialPath)
        maskLayerAnimation.duration = OLNConstans.animationDuration
        maskLayerAnimation.delegate = self
        
        let maskLayer = CAShapeLayer()
        maskLayer.addAnimation(maskLayerAnimation, forKey: nil)
        maskLayer.path = (expanded ? finalParh : initialPath)
        self.layer.mask = maskLayer
        
        let anim = CABasicAnimation(keyPath: "position.x")       
        let fromVal = initialFrame.origin.x + (expandedSize.width / 2.0)
        let toVal = self.layer.position.x
        anim.fromValue = (expanded ? fromVal : toVal)
        anim.toValue = (expanded ? toVal : fromVal)
        anim.duration = OLNConstans.animationDuration
        self.layer.addAnimation(anim, forKey: nil)
        anim.delegate = self
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if !expanded {
            layoutConstraintWidth.constant = initialFrame.size.width
            self.layoutIfNeeded()
            drawExpandedBackground = false
            self.setNeedsDisplay()
        }

        if (layoutConstraintLeadingSpace != nil) {
            layoutConstraintLeadingSpace?.priority = expanded ? 999 : 250
            self.layoutIfNeeded()
        }
    }
}
