//
//  TitleArrowView.swift
//  loca
//
//  Created by ext.zhaoxueli1 on 2022/6/27.
//

import Foundation
import UIKit
import SnapKit
class TitleArrowView: UIView {
    //    var nameStr = NSString()
    var _nameStr:String?
    var _valueStr = NSString()
    var _showState = Bool()
    var _showArrow = Bool()
    
    
    private var subNameLabel = UILabel.init()
    private var nameLabel = UILabel.init()
    private var valueLabel : UILabel!
    private var arrowImg   : UIImageView!
    private var lineView   : UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    /// 初始化控件
    func setupView()  {
        nameLabel = UILabel.init()
        nameLabel .setContentCompressionResistancePriority(.required, for: .horizontal)
        self.addSubview(nameLabel)
        nameLabel.textColor = UIColor(hex: "#1A1A1A")
        nameLabel.sizeToFit()
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
            //            make.top.equalToSuperview().offset(0).priority(.low)
        }
        
        subNameLabel = UILabel.init()
        subNameLabel .setContentCompressionResistancePriority(.required, for: .horizontal)
        self.addSubview(subNameLabel)
        subNameLabel.textColor = UIColor.black
        subNameLabel.sizeToFit()
        subNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.right)
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
            //            make.top.equalToSuperview().offset(0).priority(.low)
        }
        
        arrowImg = UIImageView.init()//UIImageView.init(image: (UIImage(named: "addcustomer_right")))
        arrowImg.image = UIImage.bm_icon(withName: "addcustomer_right", imageSize: CGSize(width: 10, height: 10), color: UIColor(hex: "#999999"))
        self.addSubview(arrowImg)
        arrowImg.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(-13.5)
            make.size.equalTo(12).priority(.high)
            //            make.top.equalToSuperview().offset(0).priority(.low)
        }
        
        valueLabel = UILabel.init()
        self.addSubview(valueLabel)
        valueLabel.textColor = UIColor.black
        valueLabel.snp.makeConstraints { (make) in
            make.right.equalTo(arrowImg.snp_leftMargin).offset(-10)
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
            //            make.top.equalToSuperview().offset(0).priority(.low)
        }
        
        lineView = UIView.init()
        let color = UIColor.red
        let hex = color.hexStringToUIColor(hex: "#F4F6F6")
        lineView.backgroundColor = hex
        self.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.top.equalTo(valueLabel.snp.bottom).offset(-1)
            make.left.right.equalTo(0)
            make.height.equalTo(0.5)
        }
        
    }
    //本质上 _name 这个变量存储真正的值，name 这个变量更多的作用相当于提供了一个方法，提供了其set和get方法，通过他的set和get方法给 _name 赋值。
    // 写_name 会死循环
    var nameStr : String? {
        set {
            _nameStr = newValue
            nameLabel.text = newValue
        }
        get {
            return _nameStr
        }
    }
    //以上就是需要额外创建一个变量来存储读取，很不方便,使用didSet就可以很好的去规避这样的问题，并且可以监视变量改变前后的值变化情况
    var valueStr:String? {
        willSet {
            guard let name = valueStr else { return }
            print("my name is \(name)")
        }
        didSet {
            print("did set"+valueStr!)
            valueLabel.text = valueStr
        }
    }
    //Setter的访问级别可以低于对应的Getter的访问级别，这样就可以控制变量、属性或下标索引的读写权限。
    var subNameStr:String? {
        willSet {
            guard let name = subNameStr else { return }
            print("Will set an new value \(name) to age")
        }
        didSet {
            //??  :nil 的聚合运算  合并空值运算符 a ?? b 如果可选项 a 有值则展开，如果没有值，是 nil，则返回默认值 b
            //表达式 a 必须是一个可选类型，表达式 b 必须与 a 的存储类型相同 等同于 a != nil ? a! : b
            
            var fff : [String]?
            let k=["test"] as? [String] ?? ["str1", "str2", "str3"]
            print("是啥啊\(k)")
            let ff=fff as? [String] ?? ["str1", "str2", "str3"]
            print("是啥啊\(ff)")

            print("subNameStr filed changed form \(String(describing: oldValue ?? subNameStr))")
            print("did set"+subNameStr!)
            subNameLabel.text = subNameStr
        }
    }
    
    var showState: Bool {
        get { return true }
        set {
            valueLabel.isHidden = newValue
        }
    }
    
    var showArrow: Bool {
        get { return true }
        set {
            arrowImg.isHidden = newValue
        }
    }
    
//    @IBOutlet weak var nameLabel: UILabel!
//        var newModel : AllShopInfoModel!
//        var model : AllShopInfoModel {
//            set {
//                self.newModel = newValue
//                self.nameLabel.text = NSString().showLanguageValueWithSimplified(self.newModel.title_zh, traditional: self.newModel.title_ch, english: self.newModel.title_en, andCurrentLanguage: appLanguage)
//            }
//            get {
//                return self.newModel
//            }
//        }
}
