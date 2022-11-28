//
//  FallAnimation.swift
//  MyFirstOCUseSwiftDemo
//
//  Created by jabraknight on 2019/7/30.
//  Copyright © 2019 jabraknight. All rights reserved.
//

import Foundation
import UIKit

struct FallAnimation: ExplosionAnimationProtocol {
    var oldPosition: CGPoint
    
    var newPosition: CGPoint
    
    var scale: CGFloat = 0.2 + CGFloat(arc4random_uniform(2))
    
    var duration: CFTimeInterval = 2
    
    var repeatCount: Float = 1
    
    func animation() -> CAAnimation {
        let positionBasicAnimation = CABasicAnimation(keyPath: "position")
        positionBasicAnimation.duration = duration
        positionBasicAnimation.fromValue = NSValue.init(cgPoint:oldPosition)
        positionBasicAnimation.toValue = NSValue.init(cgPoint:newPosition)
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = duration
        scaleAnimation.fromValue = 1
        scaleAnimation.toValue = scale
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = duration
        groupAnimation.repeatCount = repeatCount
        groupAnimation.animations = [positionBasicAnimation,scaleAnimation]
        return groupAnimation
    }
    
    func resetLayerProperty(layer: CALayer) {
        layer.position = newPosition
        layer.transform = CATransform3DMakeScale(scale, scale, 1)
    }
    
    init(position: CGPoint, targetViewSize: CGSize) {
        let x = position.x - CGFloat(arc4random_uniform(UInt32(targetViewSize.width)))
        let y = position.y + CGFloat(arc4random_uniform(UInt32(targetViewSize.height)))
        
        self.newPosition = CGPoint(x: x, y: y)
        self.oldPosition = position
    }
}
