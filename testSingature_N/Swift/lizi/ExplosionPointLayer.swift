//
//  ExplosionPointLayer.swift
//  MyFirstOCUseSwiftDemo
//
//  Created by jabraknight on 2019/7/30.
//  Copyright © 2019 jabraknight. All rights reserved.
//

import Foundation
import UIKit

class ExplosionPointLayer: CAShapeLayer {
    var explosionAnimation: ExplosionAnimationProtocol?
    func beginAnimation() {
        if let animation = explosionAnimation?.animation(){
            animation.delegate = (self as! CAAnimationDelegate)
            self.add(animation, forKey: "explosion")
            explosionAnimation?.resetLayerProperty(layer: self)
        }
    }
    func animationDidStop(anim: CAAnimation, finished flag: Bool){
        self.removeFromSuperlayer()
    }
}
