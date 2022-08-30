//
//  ThreeCell.swift
//  loca
//
//  Created by ext.zhaoxueli1 on 2022/6/27.
//

import Foundation
import UIKit
import SnapKit
/*
 /** 标签 */
 @property (nonatomic, strong) UILabel *nameLabel;
 /** 箭头 */
 @property (nonatomic, strong) UIImageView *arrowImg;
 /** 内容 */
 @property (nonatomic, strong) UILabel *valueLabel;

 @property (nonatomic, strong) UIView *lineView;
 */
class SetupJurisdictionTableViewCell : UITableViewCell {
    //fileprivate 文件内私有，只能在当前源文件中使用
    //private 只能在类中访问，离开了这个类或者结构体的作用域外面就无法访问
    fileprivate var setupTitleArrowView : TitleArrowView!
    var _nameStr:String?
    var _valueStr:String?

    
    var _isFirst = Bool()
    var _isLast = Bool()
    var _showState = Bool()


    /*
     var a : String? //a 为nil
     var b : String! //b 为nil
     var a_test = a //a_test为nil
     var b_test = b //b_test为nil
     声明变量时的 ？只是单纯的告诉Swift这是Optional的，如果没有初始化就默认为nil，
     通过！声明，则之后对该变量操作的时候都会隐式的在操作前添加一个！

     问号？
     a.声明时添加？，告诉编译器这个是Optional的，如果声明时没有手动初始化，就自动初始化为nil
     b.在对变量值操作前添加？，判断如果变量时nil，则不响应后面的方法。
     叹号！
     a.声明时添加！，告诉编译器这个是Optional的，并且之后对该变量操作的时候，都隐式的在操作前添加！
     b.在对变量操作前添加！，表示默认为非nil，直接解包进行处理

     */
    var contentRootView   : UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        self.setUpUI()
    }
    
    func setUpUI() {
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
    var valueStr : String? {
        set {
            _valueStr = newValue
            setupTitleArrowView.valueStr = newValue
        }
        get {
            return _valueStr
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
    var showState: Bool {
        get { return true }
        set {
            setupTitleArrowView.showState = newValue
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
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
}

