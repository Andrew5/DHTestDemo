//
//  UIViewExtension.swift
//  MyFirstOCUseSwiftDemo
//
//  Created by jabraknight on 2019/7/30.
//  Copyright © 2019 jabraknight. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    
    public func colorOfPoint(point:CGPoint) -> UIColor
    {
        var pixel:[CUnsignedChar] = [0,0,0,0]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        
        let context = CGContext(data: &pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        
//        CGContextTranslateCTM(context!, -point.x, -point.y)
        context!.translateBy(x: -point.x, y:-point.y)
        
//        if Thread.isMainThread {
//            //code
//            print("主线程")
//        } else {
//            DispatchQueue.main.async {
//                //code
//                print("主线程")
                self.layer.render(in: context!)
//            }
//        }
        
        let red: CGFloat = CGFloat(pixel[0]) / 255.0
        let green: CGFloat = CGFloat(pixel[1]) / 255.0
        let blue: CGFloat = CGFloat(pixel[2]) / 255.0
        let alpha: CGFloat = CGFloat(pixel[3]) / 255.0
        
        return UIColor(red:red, green: green, blue:blue, alpha:alpha)
    }
}
