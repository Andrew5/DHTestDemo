//
//  Common.swift
//  MyFirstOCUseSwiftDemo
//
//  Created by jabraknight on 2019/7/24.
//  Copyright © 2019 jabraknight. All rights reserved.
//

import Foundation
//当前系统版本
let kVersion = (UIDevice.current.systemVersion as NSString).floatValue
//      屏幕宽度
let kScreenW = UIScreen.main.bounds.width
//屏幕高度
let kScreenH = UIScreen.main.bounds.height

//以6的比例设置
let kRatioToIP6H = kScreenH/667
let kRatioToIP6W = kScreenW/375


//MARK: -颜色方法
func RGBA (_ r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat)-> UIColor{
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

//MARK: 不透明颜色
func RGBColor (_ r:CGFloat,g:CGFloat,b:CGFloat)-> UIColor{
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
}

//MARK: IOS 8以上
func IS_IOS8() -> Bool { return (UIDevice.current.systemVersion as NSString).doubleValue >= 8.0 }



// MARK:- 自定义打印方法
func LGJLog<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    #if DEBUG
    
    let fileName = (file as NSString).lastPathComponent
    
    print("\(fileName):(\(lineNum))-\(message)")
    
    #endif
}
/// 将给定的图像进行拉伸，并且返回'新'的图像
///
/// - Parameters:
/// - size: 指定大小
/// - fillColor: 填充颜色
/// - Returns: UIImage
func cornerImage(with size: CGSize, fill fillColor: UIColor?, lineColor: UIColor = .lightGray, completed: @escaping (_ image: UIImage?) -> Void) -> UIImage? {
//func xz_cornerImage(size: CGSize?, fill fillColor: UIColor = .white, lineColor: UIColor = .lightGray ) -> <#Return Type#> {
    // 看程序执行耗时
    let start: TimeInterval = CACurrentMediaTime()
    var size = size
    if size == nil || size.width == 0 {
        size = CGSize(width: 34, height: 34)
    }
    let rect = CGRect(origin: CGPoint(), size: size)
    // 1.利用绘图，建立上下文 - 内存中开辟一个地址，跟屏幕无关!
    /**参数:
     size: 绘图的尺寸
     不透明:false / true
     scale:屏幕分辨率，生成的图片默认使用 1.0 的分辨率，图像质量不好;可以指定 0 ，会选择当前设备的屏
     */
    UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
    // 2.设置被裁切的部分的填充颜色
    fillColor?.setFill()
    UIRectFill(rect)
    // 3.利用 ⻉塞尔路径 实现 裁切 效果
    // 1>实例化一个圆形的路径
    let path = UIBezierPath.init(ovalIn: rect)
    // 2>进行路径裁切 - 后续的绘图，都会出现在圆形路径内部，外部的全部干掉 path.addClip()
    // 4.绘图 drawInRect 就是在指定区域内拉伸屏幕 draw(in: rect)
    // 5.绘制内切的圆形
    let ovalPath = UIBezierPath.init(ovalIn: rect)
    ovalPath.lineWidth = 2
    lineColor.setStroke()
    ovalPath.stroke()
    //      UIColor.darkGray.setStroke()
    //      path.lineWidth = 2
    //      path.stroke()
    // 6.取得结果
    let result = UIGraphicsGetImageFromCurrentImageContext()
    // 7.关闭上下文
    UIGraphicsEndImageContext()
    // FIXME: 查看是否耗时
    print("耗时 - \(CACurrentMediaTime() - start)")
    // 8.返回结果
    return result
}
