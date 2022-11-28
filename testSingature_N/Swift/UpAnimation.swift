//
//  UpAnimation.swift
//  MyFirstOCUseSwiftDemo
//
//  Created by jabraknight on 2019/7/30.
//  Copyright © 2019 jabraknight. All rights reserved.
//

import Foundation
import UIKit

struct UpAnimation: ExplosionAnimationProtocol {
    
    var oldPosition: CGPoint
    var newPosition: CGPoint
    var scale: CGFloat = 0.5 + CGFloat(arc4random_uniform(2))
    var duration: CFTimeInterval = 2
    var repeatCount: Float = 1
    
    init(position: CGPoint, targetViewSize: CGSize) {
        
        var x: CGFloat
        
        // random x,y
        let result = arc4random_uniform(2)
        if result == 0 {
            x = position.x + CGFloat(arc4random_uniform(UInt32(targetViewSize.width)))
        } else {
            x = position.x - CGFloat(arc4random_uniform(UInt32(targetViewSize.width)))
        }
        
        let y = position.y - CGFloat(arc4random_uniform(UInt32(targetViewSize.height)))
        
        self.newPosition = CGPoint(x: x, y: y+1)
        self.oldPosition = position
    }
    
    func animation() -> CAAnimation {
        
        let positionAnimation = CABasicAnimation(keyPath: "position")
        
        positionAnimation.duration = duration
        positionAnimation.fromValue = NSValue.init(cgPoint: oldPosition)
        positionAnimation.toValue = NSValue.init(cgPoint: newPosition)
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        
        scaleAnimation.duration = duration;
        scaleAnimation.fromValue = 1
        scaleAnimation.toValue = scale
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        
        opacityAnimation.duration = duration;
        opacityAnimation.fromValue = 0.5
        opacityAnimation.toValue = 1
        
        let groupAnimation = CAAnimationGroup()
        
        groupAnimation.duration = duration
        groupAnimation.repeatCount = repeatCount
        groupAnimation.animations = [positionAnimation, scaleAnimation, opacityAnimation]
        groupAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        
        return groupAnimation
    }
    
    func resetLayerProperty(layer: CALayer) {
        layer.position = newPosition
        layer.transform = CATransform3DMakeScale(scale, scale, 1)
    }
}
