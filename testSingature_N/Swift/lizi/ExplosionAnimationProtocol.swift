//
//  ExplosionAnimationProtocol.swift
//  MyFirstOCUseSwiftDemo
//
//  Created by jabraknight on 2019/7/30.
//  Copyright © 2019 jabraknight. All rights reserved.
//

import Foundation
import UIKit

protocol ExplosionAnimationProtocol {
    
    // 粒子初始位置
    var oldPosition: CGPoint { set get }
    
    // 粒子最终位置
    var newPosition: CGPoint { set get }
    
    // 缩放
    var scale: CGFloat { set get }
    
    // 动画时长
    var duration: CFTimeInterval { set get }
    
    // 动画重复次数
    var repeatCount: Float { set get }
    
    // 生成动画
    func animation() -> CAAnimation
    
    // 设置动画完之后的属性
    func resetLayerProperty(layer: CALayer)
}
