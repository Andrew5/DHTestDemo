//
//  Cell.swift
//  loca
//
//  Created by ext.zhaoxueli1 on 2022/6/27.
//

import Foundation
import UIKit
import SnapKit

class SetupOneTableViewCell:UITableViewCell {

    var _nameStr:String?
    
    var _subNameStr:String?

    var contentRootView   : UIView!
    var setupTitleArrowView : TitleArrowView!

    var _isFirst = Bool()
    var _isLast = Bool()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        self.setupView()
    }
    /// 初始化控件
    func setupView()  {
        contentRootView = UIView.init()
        contentRootView.backgroundColor = UIColor.white
        contentView.addSubview(contentRootView)
        contentRootView.snp.makeConstraints { (make) in
            make.left.equalTo(8)
            make.right.equalTo(-8)
            make.top.equalTo(contentView.snp.top)
            make.bottom.equalTo(contentView.snp.bottom)
//            make.top.equalToSuperview().offset(0).priority(.low)
        }
        setupTitleArrowView = TitleArrowView.init()
        contentRootView.addSubview(setupTitleArrowView)
        setupTitleArrowView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.right.equalTo(-8)
            make.height.equalTo(44);
        }
        
        let bottomButton = DHCButton.button(withDHCType: .DHCButtonType1)
        contentRootView.addSubview(bottomButton!)
        bottomButton?.setTitle("测试", for: .normal)
        bottomButton?.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.right.equalTo(-100)
            make.height.equalTo(44);
            make.width.equalTo(100);
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentRootView .layoutIfNeeded()
        if (_isFirst == true)
        {
            setCornersRadius(contentRootView, radius: 8.0, roundingCorners: [[.topLeft, .topRight]])
        }
        if (_isLast == true)
        {
            setCornersRadius(contentRootView, radius: 8.0, roundingCorners: [[.bottomLeft, .bottomRight]])
        }
    }
    
    var nameStr : String? {
        set {
            _nameStr = newValue
            setupTitleArrowView.nameStr = newValue
        }
        get {
            return _nameStr
        }
    }
    var subNameStr : String? {
        set {
            _subNameStr = newValue
            setupTitleArrowView.subNameStr = _subNameStr
            setupTitleArrowView.showArrow = true
        }
        get {
            return _subNameStr
        }
    }
    var isFirst: Bool {
        get { return true }
        set {
            _isFirst = newValue
        }
    }
    
    var isLast: Bool {
        get { return true }
        set {
            _isLast = newValue
        }
    }
}
func setCornersRadius(_ view: UIView!, radius: CGFloat, roundingCorners: UIRectCorner) {
    if view == nil {
        return
    }
    let maskPath = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: roundingCorners, cornerRadii: CGSize(width: radius, height: radius))
    let maskLayer = CAShapeLayer()
    maskLayer.frame = view.bounds
    maskLayer.path = maskPath.cgPath
    maskLayer.shouldRasterize = true
    maskLayer.rasterizationScale = UIScreen.main.scale
    
    view.layer.mask = maskLayer
}
