//
//  ExplosionLayer.swift
//  MyFirstOCUseSwiftDemo
//
//  Created by jabraknight on 2019/7/30.
//  Copyright © 2019 jabraknight. All rights reserved.
//

import Foundation
import UIKit
class ExplosionLayer: CALayer {
    //?可选类型的变量,并且没有设置缺省值,该变量会自动被设置为默认值nil
    private weak var targetView: UIView?
    private weak var parentLayerL: CALayer?
    var semaphoreSignal = DispatchSemaphore(value: 1)
    var targetSize: CGSize {
        if let targetView = self.targetView {
            return targetView.frame.size
        }
        return CGSize(width: 0, height: 0)
    }
    //声明一个位置、颜色字典
    var frameDict: [String: CGRect] = [:]
    var colorDict: [String: UIColor] = [:]
    
    var animationType: ExplosionAnimationType = ExplosionAnimationType.FallAnimation
    //静态方法 指向返回类型为layer的对象
    class func createLayer(superLayer: CALayer, _ targetView: UIView,_ animationType: ExplosionAnimationType) ->ExplosionLayer {
        let layer = ExplosionLayer()
        layer.frame = targetView.frame
        layer.backgroundColor = UIColor.red.cgColor
        layer.targetView = targetView
        layer.parentLayerL = superLayer
        layer.animationType = animationType
        return layer
    }
    func explode() {
        //调用震动效果
        self.shake()
    }
    // 创建信号量
    private func createSemaphore() {
        self.semaphoreSignal = DispatchSemaphore(value: 0)
    }
    //震动效果
    private func shake(){
        //调用信号量
        self.createSemaphore()
        // 计算位置，色值
        self.caculate()
        
        let shakeAnimation = CAKeyframeAnimation(keyPath: "position")
        shakeAnimation.values = [NSValue.init(cgPoint:self.position),NSValue.init(cgPoint:CGPoint(x: self.position.x, y: self.position.y+1)),NSValue.init(cgPoint:CGPoint(x:self.position.x+1,y:self.position.y-1)),NSValue.init(cgPoint:CGPoint(x:self.position.x-1,y:self.position.y+1))]
        shakeAnimation.duration = 0.2
        shakeAnimation.repeatCount = 15
        shakeAnimation.delegate = self as? CAAnimationDelegate
        shakeAnimation.isRemovedOnCompletion = true
        //self.targetView为可选项
        self.targetView?.layer.add(shakeAnimation, forKey: "shake")
    }
    //后台计算点和颜色
    private func caculate(){
        
        DispatchQueue.global().async { () -> Void in
            
            let startTime = CFAbsoluteTimeGetCurrent()
            
            self.frameDict = ExplosionHelper.caculatePositions(targetViewSize: self.targetSize)
            
            if self.targetView == self.targetView {
                self.colorDict = ExplosionHelper.caculatePointColor(dict: self.frameDict,self.targetView!)//self.targetView我知道这个可选项里边有值，展开吧:强制展开
            }
            
            let endTime = CFAbsoluteTimeGetCurrent()
            print("waste time: \(endTime - startTime)")
            
            self.semaphoreSignal.signal()
        }
    }

    func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        
        // wait for caculate
        self.semaphoreSignal.wait()
        
        print("shake animation stop")
        
        // begin explode
        if let targetView = self.targetView {
            self.parentLayerL?.addSublayer(self)
            ExplosionHelper.createExplosionPoints(containerLayer: self, targetView: targetView, animationType: self.animationType)
            
            self.targetView!.isHidden = true
        }
    }
}
