//
//  IrregularButton.swift
//  MyFirstOCUseSwiftDemo
//
//  Created by jabraknight on 2019/9/17.
//  Copyright © 2019 jabraknight. All rights reserved.
//

import Foundation
// 这里定义了一个枚举，定义了我们这个例子中按钮绘制的类型
enum BtnType {
    case leftUp
    case leftDown
    case rightUp
    case rightDown
    case center
}

class IrregularButton: UIButton {
    
    // 绘制出图形的path
    private var path = UIBezierPath()
    
    // 最终要呈现的图形
    private var drawLayer = CAShapeLayer()
    
    // 显示我们需要显示的文字
    private var textLayer = CATextLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 将要显示的layer添加到自身的layer中
        self.layer.addSublayer(self.drawLayer)
        self.layer.addSublayer(self.textLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 外部传入的path，供我们绘制
    func path(type: BtnType) -> IrregularButton {
        
        let path = UIBezierPath()
        
        switch type {
        case .leftUp:
            
            path.move(to: CGPoint(x: 60, y: 100))
            path.addLine(to: CGPoint(x: 0, y: 100))
            path.addArc(withCenter: CGPoint(x: 100, y: 100), radius: 100, startAngle: .pi, endAngle: .pi*1.5, clockwise: true)
            path.addLine(to: CGPoint(x: 100, y: 60))
            path.addArc(withCenter: CGPoint(x: 100, y: 100), radius: 40, startAngle: .pi*1.5, endAngle: .pi, clockwise: false)
            path.close()
            
            self.path = path
            
        case .leftDown:
            path.move(to: CGPoint(x: 60, y: 100))
            path.addLine(to: CGPoint(x: 0, y: 100))
            path.addArc(withCenter: CGPoint(x: 100, y: 100), radius: 100, startAngle: .pi, endAngle: .pi*0.5, clockwise: false)
            path.addLine(to: CGPoint(x: 100, y: 140))
            path.addArc(withCenter: CGPoint(x: 100, y: 100), radius: 40, startAngle: .pi*0.5, endAngle: .pi, clockwise: true)
            path.close()
            
            self.path = path
        case .rightUp:
            path.move(to: CGPoint(x: 100, y: 60))
            path.addLine(to: CGPoint(x: 100, y: 0))
            path.addArc(withCenter: CGPoint(x: 100, y: 100), radius: 100, startAngle: .pi*1.5, endAngle: 0, clockwise: true)
            path.addLine(to: CGPoint(x: 140, y: 100))
            path.addArc(withCenter: CGPoint(x: 100, y: 100), radius: 40, startAngle: 0, endAngle: .pi*1.5, clockwise: false)
            path.close()
            
            self.path = path
        case .rightDown:
            path.move(to: CGPoint(x: 140, y: 100))
            path.addLine(to: CGPoint(x: 200, y: 100))
            path.addArc(withCenter: CGPoint(x: 100, y: 100), radius: 100, startAngle: 0, endAngle: .pi*0.5, clockwise: true)
            path.addLine(to: CGPoint(x: 100, y: 140))
            path.addArc(withCenter: CGPoint(x: 100, y: 100), radius: 40, startAngle: .pi*0.5, endAngle: 0, clockwise: false)
            path.close()
            
            self.path = path
        case .center:
            path.move(to: CGPoint(x: 140, y: 100))
            path.addArc(withCenter: CGPoint(x: 100, y: 100), radius: 40, startAngle: 0, endAngle: .pi*2, clockwise: true)
            path.close()
            
            self.path = path
        }
        
        self.drawLayer.path = self.path.cgPath
        
        // 绘制完成，通知layer去刷新界面
        setNeedsDisplay()
        
        return self
    }
    
    // 设置需要显示的文字
    func text(text: String) {
        
        // 获取显示文字的size
        let stringSize = text.boundingRect(with: CGSize(width:100,height:CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14)], context: nil).size
        
        // 设置textLayer的位置
        textLayer.frame = CGRect(x: self.path.bounds.origin.x+(self.path.bounds.size.width/2)-(stringSize.width/2), y: self.path.bounds.origin.y+(self.path.bounds.size.height/2)-(stringSize.height/2), width: stringSize.width, height: stringSize.height)
        
        textLayer.string = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor:UIColor.black,
                                                                         NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14)])
        textLayer.backgroundColor = UIColor.clear.cgColor
        
        textLayer.isWrapped = false//设置是否自动换行
        textLayer.contentsScale = UIScreen.main.scale//寄宿图的像素尺寸和视图大小的比例,不设置为屏幕比例文字就会像素化
        
        setNeedsDisplay()
    }
    
    // 设置按钮的背景颜色
    func backgroundColor(color: UIColor) -> IrregularButton {
        
        self.drawLayer.fillColor = color.cgColor
        
        setNeedsDisplay()
        
        return self
    }
    
    // 重写此方法。判断点是否在自身path所包含的区域内。包含则返回true，代表自身处理；否则返回false。
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if self.path.contains(point) {
            return true
        }
        return false
    }
}
