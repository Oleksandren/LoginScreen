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
    @IBInspectable var expandedSize: CGSize = CGSize.zero
    var expanded = false
    var drawExpandedBackground = false
    var initialFrame: CGRect!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialFrame = self.frame
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        var imageRect = CGRect.zero
        imageRect.size = initialFrame.size
        return imageRect
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if drawExpandedBackground {
            let context = UIGraphicsGetCurrentContext()
            context?.saveGState();
            context?.addRect((context?.boundingBoxOfClipPath)!);
            context?.addArc(center: CGPoint(x: 19, y: 19),
                       radius: 19,
                       startAngle: 0,
                       endAngle: CGFloat(Float(Double.pi) * 2),
                       clockwise: false)
            context?.closePath();
            context?.clip(using: .evenOdd)

            context?.move(to: CGPoint(x: 0, y: 0));
            context?.addLine(to: CGPoint(x: 168, y: 0));
            context?.addLine(to: CGPoint(x: 168, y: 38));
            context?.addLine(to: CGPoint(x: 0, y: 38));
            context?.addLine(to: CGPoint(x: 0, y: 0));
            context?.setFillColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 0.5);
            context?.fillPath();
            context?.restoreGState();
        }
    }
    
    func checkSettings() -> Bool {
        if expandedSize.equalTo(CGSize.zero) {
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
        
        var initialBounds = CGRect.zero
        initialBounds.size = initialFrame.size
        let initialCornerRadius = max(initialBounds.height, initialBounds.width)
        let initialPath = UIBezierPath(roundedRect: initialBounds, cornerRadius: initialCornerRadius).cgPath
        let finalCornerRadius = max(expandedSize.width, expandedSize.height)
        let finalRect = CGRect(x: 0, y: 0, width: expandedSize.width, height: expandedSize.height)
        let finalParh  = UIBezierPath(roundedRect: finalRect, cornerRadius: finalCornerRadius).cgPath
        
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = (expanded ? initialPath : finalParh)
        maskLayerAnimation.toValue = (expanded ? finalParh : initialPath)
        maskLayerAnimation.duration = OLNConstans.animationDuration
        maskLayerAnimation.delegate = self
        
        let maskLayer = CAShapeLayer()
        maskLayer.add(maskLayerAnimation, forKey: nil)
        maskLayer.path = (expanded ? finalParh : initialPath)
        self.layer.mask = maskLayer
        
        let anim = CABasicAnimation(keyPath: "position.x")       
        let fromVal = initialFrame.origin.x + (expandedSize.width / 2.0)
        let toVal = self.layer.position.x
        anim.fromValue = (expanded ? fromVal : toVal)
        anim.toValue = (expanded ? toVal : fromVal)
        anim.duration = OLNConstans.animationDuration
        self.layer.add(anim, forKey: nil)
        anim.delegate = self
    }
    
    override func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
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
