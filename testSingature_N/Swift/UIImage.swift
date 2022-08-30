//
//  UIImage.swift
//  testSingature
//
//  Created by 赵学礼 on 2022/6/28.
//  Copyright © 2022 zk. All rights reserved.
//

import Foundation
import UIKit
extension UIImage {
    //  Converted to Swift 5.6.1 by Swiftify v5.6.23302 - https://swiftify.com/
    class func bm_icon(withName name: String?, imageSize: CGSize, fontSize: CGFloat, color: UIColor) -> UIImage? {
        if (name == nil) {
            assert((name != nil), "icon object should not be nil, check if the font file is added to the application bundle and you're using the correct font name.")
            return nil
        }
        UIGraphicsBeginImageContextWithOptions(imageSize, false, UIScreen.main.scale)
        let fontString = bm_attributedString(withIcon: name, fontSize: fontSize, color: color)
        let iconSize = fontString!.size()
        let xOffset = (imageSize.width - iconSize.width) / 2.0
        let yOffset = (imageSize.height - iconSize.height) / 2.0
        let rect = CGRect(x: xOffset, y: yOffset, width: iconSize.width, height: iconSize.height)
        fontString!.draw(in: rect)
        let iconImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return iconImage
    }
    
    class func bm_icon(withName name: String?, imageSize: CGSize, color: UIColor?) -> UIImage? {
        let size = imageSize.width > imageSize.height ? imageSize.height : imageSize.width
        return self.bm_icon(withName: name, imageSize: imageSize, fontSize: size, color: color!)
    }
    class func bm_attributedString(withIcon iconName: String?, fontSize: CGFloat, color: UIColor?) -> NSAttributedString? {
        let font = UIFont.systemFont(ofSize: fontSize, weight: .heavy)
        var attributed: [AnyHashable : Any]? = nil
        
        attributed = [
            NSAttributedString.Key.font: font
        ]
        if color != nil {
            attributed![NSAttributedString.Key.foregroundColor] = color
        }
        return NSAttributedString(string: ">", attributes:attributed as? [NSAttributedString.Key : Any])
    }
}
