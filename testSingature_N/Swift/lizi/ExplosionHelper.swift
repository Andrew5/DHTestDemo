//
//  ExplosionHelper.swift
//  MyFirstOCUseSwiftDemo
//
//  Created by jabraknight on 2019/7/30.
//  Copyright © 2019 jabraknight. All rights reserved.
//

import Foundation
import UIKit

enum ExplosionAnimationType: Int {
    case FallAnimation
    case UpAnimation
}
class ExplosionHelper {
    class func caculatePositions(targetViewSize: CGSize)->[String:CGRect] {
        let pointWidth: CGFloat = 2
        let pointHeight = pointWidth
        let margin: CGFloat = 1
        
        let targetViewWidth = targetViewSize.width
        let targetViewHeight = targetViewSize.height
        
        // 计算水平，竖直方向粒子个数
        let hCount: Int = Int(targetViewWidth) / Int(pointWidth + margin)
        let VCount: Int = Int(targetViewHeight) / Int(pointHeight + margin)
        
        var frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
        var rectDict: [String: CGRect] = [:]
        for i in 0..<hCount {
            for j in 0..<VCount {
                frame = CGRect(x:CGFloat(pointWidth + margin) * CGFloat(i), y: CGFloat(pointHeight + margin) * CGFloat(j), width: pointWidth, height: pointHeight)
                // "i-j":frame
                let key = String(format: "%d-%d", i, j)
                rectDict[key] = frame
            }
        }
        
        return rectDict
    }
    // 计算每个点的颜色值
    class func caculatePointColor(dict: [String: CGRect], _ targetView: UIView) -> [String: UIColor] {
        
        var colorDict: [String: UIColor] = [:]
        for (key, rect) in dict {
            let color = targetView.colorOfPoint(point: rect.origin)
            colorDict[key] = color
        }
        
        return colorDict
    }
    // 计算水平方向粒子数
    class func caculatePointHCount(targetViewWidth: CGFloat) -> Int {
        
        let pointWidth: CGFloat = 2
        let margin: CGFloat = 1
        
        // 计算水平，水平方向粒子个数
        let hCount: Int = Int(targetViewWidth) / Int(pointWidth + margin)
        
        return hCount
    }
    // 计算竖直方向粒子数
    class func caculatePointVCount(targetViewHeight: CGFloat) -> Int {
        
        let pointHeight: CGFloat = 2
        let margin: CGFloat = 1
        
        // 计算水平，竖直方向粒子个数
        let hCount: Int = Int(targetViewHeight) / Int(pointHeight + margin)
        
        return hCount
    }
    // 创建粒子，默认下落效果
    class func createExplosionPoints(containerLayer: ExplosionLayer, targetView: UIView) {
        
        self.createExplosionPoints(containerLayer: containerLayer, targetView: targetView, animationType: .FallAnimation)
    }
    /**
     创建粒子
     
     - parameter frame
     - parameter bgColor
     
     - returns: ExplosionPointLayer
     */
    class func createExplosionPointLayer(frame: CGRect, bgColor: UIColor, targetViewSize: CGSize) -> ExplosionPointLayer {
        let layer = ExplosionPointLayer()
        layer.fillColor = bgColor.cgColor
        let path: UIBezierPath = UIBezierPath(roundedRect: frame, cornerRadius: frame.size.width/2)
        layer.path = path.cgPath
        let fallAnimation = FallAnimation(position: layer.position, targetViewSize: targetViewSize)
        layer.explosionAnimation = fallAnimation
        return layer
    }
    /**
     创建动画效果
     
     - parameter type:           动画类型
     - parameter position:       起点position
     - parameter targetViewSize
     
     - returns: 返回动画
     */
    private class func createAnimationWithType(type: ExplosionAnimationType,
                                               position: CGPoint, targetViewSize: CGSize) -> ExplosionAnimationProtocol {
        switch type {
        case .FallAnimation:
//            return CAAnimation(position: position, targetViewSize: CGSizeMake(targetViewSize.width, targetViewSize.height))
            return FallAnimation(position: position, targetViewSize:CGSize(width: targetViewSize.width, height: targetViewSize.height))
            
        case .UpAnimation:
            return UpAnimation(position: position, targetViewSize: CGSize(width: targetViewSize.width, height: targetViewSize.height))
        }
    }
    /**
     创建所有粒子图层
     
     - parameter containerLayer: 父layer
     - parameter targetView:     要发生爆炸效果view
     - parameter animationType:  动画类型
     */
    class func createExplosionPoints(containerLayer: ExplosionLayer,targetView: UIView, animationType: ExplosionAnimationType) {
        let hCount = self.caculatePointHCount(targetViewWidth: containerLayer.targetSize.width)
        let vCount = self.caculatePointVCount(targetViewHeight: containerLayer.targetSize.height)
        for i in 0..<hCount{
            for j in 0..<vCount{
                let key = String(format:"%d-%d",i,j)
                if let rect = containerLayer.frameDict[key],let color = containerLayer.colorDict[key]{
                    let layer = createExplosionPointLayer(frame: rect, bgColor: color, targetViewSize: containerLayer.targetSize)
                    
                    layer.explosionAnimation = self.createAnimationWithType(type: animationType, position: layer.position, targetViewSize: containerLayer.targetSize)
                    
                }
            }
        }
        
        
    }
    
}
