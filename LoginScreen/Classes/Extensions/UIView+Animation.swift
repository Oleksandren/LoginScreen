//
//  UIView+Animation.swift
//  LoginScreen
//
//  Created by Oleksandr Nechet on 13.11.15.
//  Copyright © 2015 Oleksandr Nechet. All rights reserved.
//

import  UIKit


let OLNCircularAnimationHideWhenFinishedKey = "OLNCircularAnimationHideWhenFinishedKey"

extension UIView {
    
    //MARK: - Base animation methods
    
    class func animationFade(directionFade fade:Bool) -> CABasicAnimation {
        let animFade = CABasicAnimation(keyPath: "opacity")
        animFade.fromValue = fade ? 1.0 : 0.0
        animFade.toValue = fade ? 0.0 : 1.0
        animFade.duration = OLNConstans.animationDuration
        return animFade
    }
    
    func animationMoveUp(directionUp: Bool, andHide hide: Bool) {
        
        guard hide == Bool(self.alpha) else {
            return
        }
        self.layer.removeAllAnimations()
        self.alpha = hide ? 0.0 : 1.0
        
        let animMove = CABasicAnimation(keyPath: "position.y")
        var newPosition = self.center.y
        if (directionUp) {
            newPosition -= 2 * self.frame.size.height
        } else {
            newPosition += 2 * self.frame.size.height
        }
        animMove.fromValue = hide ? self.center.y : newPosition
        animMove.toValue = hide ? newPosition : self.center.y
        
        let animGroup = CAAnimationGroup()
        animGroup.animations = [animMove, UIView.animationFade(directionFade:hide)]
        animGroup.duration = OLNConstans.animationDuration
        self.layer.addAnimation(animGroup, forKey: nil)
    }

    func animationCircular(directionShow show: Bool, startPoint: CGPoint) {
        if show != hidden {
            return
        }
        self.layer.removeAllAnimations()
        self.hidden = false
        
        let initialRect = CGRectMake(startPoint.x, startPoint.y, 0, 0)
        let initialPath = UIBezierPath(ovalInRect: initialRect).CGPath
        
        var h = self.frame.size.height - CGRectGetMaxY(initialRect)
        h = max(CGRectGetMaxY(initialRect), h)
        
        var w = self.frame.size.width - CGRectGetMaxX(initialRect)
        w = max(CGRectGetMaxX(initialRect), w)
        
        let radius = sqrt((h * h) + (w * w))
        let finalParh = UIBezierPath(ovalInRect: CGRectInset(initialRect, -radius, -radius)).CGPath
        
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = (show ? initialPath : finalParh)
        maskLayerAnimation.toValue = (show ? finalParh : initialPath)
        maskLayerAnimation.duration = OLNConstans.animationDuration

        if !show {
            maskLayerAnimation.delegate = self
            maskLayerAnimation.setValue(false, forKey: OLNCircularAnimationHideWhenFinishedKey)
        }
        
        let maskLayer = CAShapeLayer()
        maskLayer.addAnimation(maskLayerAnimation, forKey: nil)
        
        maskLayer.path = (show ? finalParh : initialPath)
        self.layer.mask = maskLayer
    }
    
    //MARK: - Convenience methods
    
    func animationFade(directionFade fade:Bool) {
        self.layer.addAnimation(UIView.animationFade(directionFade:fade), forKey: nil)
        self.alpha = fade ? 0 : 1
    }
    
    func animationCircular(directionShow show: Bool) {
        self.animationCircular(directionShow: show, startTop: true)
    }
    
    /**
     * if startTop - false - animation begin from bottom
     */
    func animationCircular(directionShow show: Bool, startTop: Bool) {
        var startPoint = CGPointMake(self.bounds.width/2.0, 0)
        if !startTop  {startPoint.y = self.bounds.height}
        self.animationCircular(directionShow: show, startPoint: startPoint)
    }
    
    //MARK: - CAAnimation Delegate
    
    override public func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if (anim.valueForKey(OLNCircularAnimationHideWhenFinishedKey) != nil) {
            self.hidden = true
        }
    }
}