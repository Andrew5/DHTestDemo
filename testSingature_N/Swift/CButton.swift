//
//  CButton.swift
//  testSingature_N
//
//  Created by rilakkuma on 2022/9/29.
//

import Foundation
import UIKit

public enum DHCButtonType: Int{
    
    case DHCButtonType1 = 0// 通栏 Button_1 DHCButtonTypeBase01B_New
    case DHCButtonType2 // 通栏 Button_3
    case DHCButtonType3 // 通栏 Button_2
    case DHCButtonType4 // 通栏 Button_3
    case DHCButtonType5    // 主功能 Button_5
    case DHCButtonType6    // 主功能 Button_6
    case DHCButtonType7 // 通栏 Button_3
    case DHCButtonType8 // 通栏 Button_3
    case DHCButtonType9 // 通栏 Button_3

    case DHCButtonType10 // 搜索筛选/评价标签 Button_10
    case DHCButtonType11 // 单选/多选 Button_11
    case DHCButtonType12 // 单选/多选 Button_12
    case DHCButtonType18 // 悬浮 Button_18
    case DHCButtonType21 // 主功能 Button_21
    case DHCButtonType22 // 优惠券 Button_22

    case DHCButtonTypeBase01A                           // 基础Button A样式 font 13
    case DHCButtonTypeBase01B                              // 基础Button B样式 font 16
    case DHCButtonTypeBase01C                              // 基础Button C样式 font 14
    case DHCButtonTypeBase01D                              // 基础Button D样式 font 14
    case DHCButtonTypeBase01E                              // 基础Button E样式 font 13
    case DHCButtonTypeBase01F                              // 基础Button F样式 font 13
    case DHCButtonTypeBase01G                              // 基础Button G样式 font 13
    case DHCButtonTypeBase01H                              // 基础Button H样式
    case DHCButtonTypeBase01I                              // 基础Button I样式
    case DHCButtonTypeBase01J                              // 基础Button J样式
    case DHCButtonTypeBase01K                              // 基础Button K样式
    case DHCButtonTypeBase01L                              // 基础Button L样式
    case DHCButtonTypeBase01M                              // 基础Button 01M样式 反顶按钮
    case DHCButtonTypeBase02M                              // 基础Button 02M样式 购物车按钮
    case DHCButtonTypeBase03M                              // 基础Button 03M样式 历史记录按钮
    case DHCButtonTypeBase04M                              // 基础Button 04M样式 收藏按钮
    case DHCButtonTypeBase01N                              // 基础Button N样式
    case DHCButtonTypeBase01O                              // 基础Button O样式 font 14
    case DHCButtonTypeBase01P                              // 基础Button P样式
    case DHCButtonTypeBase01Q                              // 基础Button Q样式
    case DHCButtonTypeBase01R                              // 基础Button R样式 font 12
    case DHCButtonTypeBase01RB                              // 基础Button RB样式 font 12
    case DHCButtonTypeBase01S                              // 基础Button S样式 font 12
    case DHCButtonTypeBase01T                              // 基础Button T样式 font 14
    case DHCButtonTypeBase01U                              // 基础Button U样式 font 13
    case DHCButtonTypeBase01V                              // 基础Button V样式 font 14
    case DHCButtonTypeBase01W                              // 基础Button W样式 font 13
    case DHCButtonTypeBase01Y                              // 基础Button Y样式 font 12
    case DHCButtonTypeBase01Z                               // 基础Button Z样式 font 13
//    DHCButtonTypeBase01B_New,                            // 基础Button B样式  font 16 V9.0 M
    case DHCButtonTypeBase01XA                               // 基础Button XA样式 font 15 V9.0 A
//    DHCButtonTypeBase01XB,                               // 基础Button XB样式 font 15 V9.0 A
    case DHCButtonTypeBase01DA                               // 基础Button DA样式 font 12 V9.0 A
    case DHCButtonTypeBase01A_New                             // 基础Button A样式 font 13 V9.0 M
    case DHCButtonTypeBase01AA                                // 基础Button A样式 font 13 V9.0 A
    case DHCButtonTypeBase01E_New                             // 基础Button E样式 font 13 V9.0 M
    case DHCButtonTypeBase01RA_New                            // 基础Button RA样式 font 12/9 V8.0 M
    case DHCButtonTypeBase01RB_New                              // 基础Button RB样式 font 12 V9.0 M
    case DHCButtonTypeBase01YA                                   // 基础Button YA样式 font 12  V9.0 A
    case DHCButtonTypeBase01G_New                               // 基础Button G样式 font 13 V8.0 M
    case DHCButtonTypeBase01U_New                               // 基础Button U样式 font 13 V8.0 M
    case DHCButtonTypeBase01I_New                              // 基础Button I样式 V9.0 M
    case DHCButtonTypeBase01J_New                               // 基础Button J样式 V9.0 M
    case DHCButtonTypeBase01H_New                               // 基础Button H样式 V9.0 M
    case DHCButtonTypeBase01N_New                               // 基础Button N样式  V8.0 M
    case DHCButtonTypeBase01IA                             // 基础Button IA样式 V8.0 A
    case DHCButtonTypeBase02IA                             // 基础Button IA样式 V8.0 A
    case DHCButtonTypeBase01NA                             // 基础Button NA样式 V8.0 A
    case DHCButtonTypeBase02NA                             // 基础Button NA样式 V8.0 A
    case DHCButtonTypeBase01KA                             // 基础Button KA样式 V8.0 A
    case DHCButtonTypeBase02KA                             // 基础Button KA样式 V8.0 A
    case DHCButtonTypeBase01KB                             // 基础Button KB样式 V8.0 A
    case DHCButtonTypeBase02KB                             // 基础Button KB样式 V8.0 A
    case DHCButtonTypeBase01KC                             // 基础Button KC样式 V8.0 A
    case DHCButtonTypeBase02KC                             // 基础Button KC样式 V8.0 A
    case DHCButtonTypeBase01M_New                          // 基础Button 01M样式 反顶按钮 V9.0 M
    case DHCButtonTypeBase02M_New                          // 基础Button 02M样式 购物车按钮 V9.0 M
    case DHCButtonTypeBase03M_New                          // 基础Button 03M样式 历史记录按钮 V9.0 M
    case DHCButtonTypeBase04M_New                          // 基础Button 04M样式 收藏按钮 V9.0
    case DHCButtonTypeBase01Z_New                          // 基础Button Z_A样式  V9.0 M
    case DHCButtonTypeBase01E1                             // 基础Button E1样式 font 13 V8.0.6 A
    case DHCButtonTypeBase05M                               // 基础Button 05M样式 用户反馈按钮
    case DHCButtonTypeBase05M_New                           // 基础Button 05M样式 用户反馈按钮 V9.0
    case DHCButtonTypeBase02Z_New                           // 基础Button Z_B样式  V9.0 M
    case DHCButtonTypeBase01RC_New                           // 基础Button RC样式 font 12 V9.0 M
}
/*!
 *   @brief  iPhone主功能按钮 四角圆角可单独设置
 *   @author add by kongleifeng
 *   @since 8.0.0
 */
struct DHCUIRectCorner : OptionSet {
    let rawValue: Int

    static let topLeft = Self(rawValue: 1 << 0) // 左上
    static let topRight = Self(rawValue: 1 << 1) // 右上
    static let bottomLeft = Self(rawValue: 1 << 2) // 左下
    static let bottomRight = Self(rawValue: 1 << 3) // 右下
    static let allCorners = Self(rawValue: 1 << 4 /* 四角全部 */)
}
//@objc protocol DHCSegmentButtonDelegate: AnyObject {
//    @objc optional func segmentButton(_ segmentButton: DHCButton?, didSelect index: Int)//可选
//}
protocol DHCSegmentButtonDelegate: AnyObject {
    func segmentButton(_ segmentButton: DHCButton?, didSelect index: Int)//可选
}
extension DHCSegmentButtonDelegate {
    func segmentButton(_ segmentButton: DHCButton?, didSelect index: Int) {//可选
        
    }
}
private func DHCButtonColorFromeHex(_ hexColor: String?) -> UIColor? {
    
    if hexColor == nil {
        return nil
    }
    let strLen = hexColor?.count ?? 0
    if strLen < 6 || strLen > 7 {
        return nil
    }
    
    var red: CUnsignedInt = 0
    var green: CUnsignedInt = 0
    var blue: CUnsignedInt = 0
    var range = NSRange(location: 1, length: 2)

    var offset = 1
    if 6 == strLen {
        offset = 0
    }
    
    range.location = offset
    Scanner(string: ((hexColor! as NSString).substring(with: range) as NSString) as String).scanHexInt32(&red)
    range.location = offset + 2
    Scanner(string: ((hexColor! as NSString).substring(with: range) as NSString) as String).scanHexInt32(&green)
    range.location = offset + 4
    Scanner(string: ((hexColor! as NSString).substring(with: range) as NSString) as String).scanHexInt32(&blue)
    
    return UIColor(red: CGFloat(Double(red) / 255.0), green: CGFloat(Double(green) / 255.0), blue: CGFloat(Double(blue) / 255.0), alpha: 1.0)
    
}

class DHCButton: UIButton {
    ///   通用基础样式
    ///
    ///  @since 4.0
    var baseType: DHCButtonType?
    /*!
    *  @brief  是否支持适配暗黑 默认为NO
    *  设置该值的时机尽量早，建议初始化设置basetype后就设置该值
    *  @since 9.0
    */
    var canSupportAdaptDarkMode = false
    /*!
    *  @brief  是否支持适配老年版 默认为NO
    *  初始化设置baseType后, 再设置该值才会生效
    *  @since 9.5.2
    */
    var canSupportAdaptElderMode = false
    /*!
    *  @brief  是否直接使用老年版UI
    *  YES代表直接使用老年版而不跟随App老年版开关，默认为NO
    *  初始化设置baseType后, 再设置该值才会生效
    *  @since 9.5.2
    */
    var canDirectUseElderMode = false
    /*!
     *  @brief 回调代理
     *
     *  @since 4.1
     */
    var delegate: DHCSegmentButtonDelegate?
    
    var imagesDic: [AnyHashable : Any]?
    var titles: [AnyHashable]? //add by NingL P样式的按钮文案数组
    var dashLayer: CAShapeLayer? //5.0
    var lineLayer: CAShapeLayer? //8.0 add by kongleifeng 横线绘制
    var circleImageView: UIView? //8.0 add by kongleifeng 圆
    var lottieView: UIView? //9.0 _01H add lottie动画
    var bottomLine: UIView?
    var subTitleLabel: UILabel
    
    var _index: Int = 0
    let _spacing: CGFloat = 24
    let _kPButtonTitleFontSize: CGFloat = 15
    
    var borderColorNormal: UIColor?
    var borderColorHighlighted: UIColor?
    var borderColorDisabled: UIColor?
    var borderColorSelected: UIColor?
    var borderColorNormalDark: UIColor?
    var borderColorHighlightedDark: UIColor?
    var borderColorDisabledDark: UIColor?
    var borderColorSelectedDark: UIColor?
    
    var backgroundColorNormal: UIColor?
    var backgroundColorHighlighted: UIColor?
    var backgroundColorDisabled: UIColor?
    var backgroundColorSelected: UIColor?
    var backgroundColorNormalDark: UIColor?
    var backgroundColorHighlightedDark: UIColor?
    var backgroundColorDisabledDark: UIColor?
    var backgroundColorSelectedDark: UIColor?
    
    
    var gradientLayer: CAGradientLayer?
    var lineDashPattern: [NSNumber]?
    
    var gradientColorNormal: [UIColor]?
    var gradientColorHighlighted: [UIColor]?
    var gradientColorSelected: [UIColor]?
    var gradientColorDisabled: [UIColor]?
    var gradientColorNormalDark: [UIColor]?
    var gradientColorHighlightedDark: [UIColor]?
    var gradientColorSelectedDark: [UIColor]?
    var gradientColorDisabledDark: [UIColor]?
    
    
    var isShadow = false
    var isSpecial = false // v8.0 add by kongleifeng 特殊禁止
    var shadowColorNormal: UIColor?
    var shadowColorHighlighted: UIColor?
    var shadowColorSelected: UIColor?
    var shadowColorDisabled: UIColor?
    var shadowColorNormalDark: UIColor?
    var shadowColorHighlightedDark: UIColor?
    var shadowColorSelectedDark: UIColor?
    
    var shadowColorDisabledDark: UIColor?
    var shadowOffset = CGSize.zero
    var shadowOpacityNormal: CGFloat = 0.0
    var shadowOpacityHighlighted: CGFloat = 0.0
    var shadowOpacitySelected: CGFloat = 0.0
    var shadowOpacityDisabled: CGFloat = 0.0
    var shadowOpacityNormalDark: CGFloat = 0.0
    var shadowOpacityHighlightedDark: CGFloat = 0.0
    var shadowOpacitySelectedDark: CGFloat = 0.0
    
    var shadowOpacityDisabledDark: CGFloat = 0.0
    var shadowRadius: CGFloat = 0.0
    var _06MTitle: String?
    var _06MSubTitle: String?

    override init(frame: CGRect) {
        self.subTitleLabel = .init()
        super.init(frame: frame)
        titleLabel?.lineBreakMode = .byTruncatingTail
        titleLabel?.textAlignment = .center
        backgroundColor = UIColor.clear
    }

    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    /*!
     *  @brief  设置R类型按钮文字
     *
     *  @param title 主文案
     *  @param subTitle 小文案
     *
     *  @since 5.0
     */
    func setTitle(_ title: String?, subTitle: String?) {
        if self.baseType == DHCButtonType.DHCButtonType1 {
            return
        }
        var subTitleNew: String = subTitle ?? ""
        subTitleNew = subTitle?.replacingOccurrences(of: " ", with: "") ?? ""
        if (self.baseType == DHCButtonType.DHCButtonTypeBase01R && subTitleNew.utf16.count > 0){
            self.baseType = DHCButtonType.DHCButtonTypeBase01RA_New;
        }
        setAttributedTitle(nil, for: .normal)
        setAttributedTitle(nil, for: .selected)
        setTitle(title, for: .normal)
        setTitle(title, for: .selected)
        if subTitleLabel == nil {
            subTitleLabel = UILabel()
            subTitleLabel.backgroundColor = UIColor.clear
            subTitleLabel.lineBreakMode = .byTruncatingTail
            subTitleLabel.textAlignment = .center
            subTitleLabel.font = UIFont.systemFont(ofSize: 8)
            addSubview(subTitleLabel)
//            subTitleLabel?.backgroundColor = UIColor.clear
//            subTitleLabel?.lineBreakMode = .byTruncatingTail
//            subTitleLabel?.textAlignment = .center
//            subTitleLabel?.font = UIFont.systemFont(ofSize: 8)
//            addSubview(subTitleLabel ?? UILabel)
        }
//        switch self.baseType {
//        case .none:
//            <#code#>
//        case .some(.DHCButtonTypeBase01R):do {
//            if selected {
//                subTitleLabel.textColor = RED_COLOR
//            } else {
//                subTitleLabel.textColor = DHCButtonColorFromeHex("#232326")
//            }
//        }
//        case .some(.DHCButtonTypeBase01R):do {
//
//        }
//        case .some(.DHCButtonTypeBase01R):do {
//
//        }
//        case .some(.DHCButtonType1):
//            <#code#>
//        case .some(.DHCButtonType3):
//            <#code#>
//        case .some(.DHCButtonType2):
//            <#code#>
//        case .some(.DHCButtonType4):
//            <#code#>
//        case .some(.DHCButtonType7):
//            <#code#>
//        case .some(.DHCButtonType8):
//            <#code#>
//        case .some(.DHCButtonType9):
//            <#code#>
//        case .some(.DHCButtonType5):
//            <#code#>
//        case .some(.DHCButtonType6):
//            <#code#>
//        case .some(.DHCButtonType10):
//            <#code#>
//        case .some(.DHCButtonType11):
//            <#code#>
//        case .some(.DHCButtonType12):
//            <#code#>
//        case .some(.DHCButtonType18):
//            <#code#>
//        case .some(.DHCButtonType21):
//            <#code#>
//        case .some(.DHCButtonType22):
//            <#code#>
//        case .some(.DHCButtonTypeBase01A):
//            <#code#>
//        case .some(.DHCButtonTypeBase01B):
//            <#code#>
//        case .some(.DHCButtonTypeBase01C):
//            <#code#>
//        case .some(.DHCButtonTypeBase01D):
//            <#code#>
//        case .some(.DHCButtonTypeBase01E):
//            <#code#>
//        case .some(.DHCButtonTypeBase01F):
//            <#code#>
//        case .some(.DHCButtonTypeBase01G):
//            <#code#>
//        case .some(.DHCButtonTypeBase01H):
//            <#code#>
//        case .some(.DHCButtonTypeBase01I):
//            <#code#>
//        case .some(.DHCButtonTypeBase01J):
//            <#code#>
//        case .some(.DHCButtonTypeBase01K):
//            <#code#>
//        case .some(.DHCButtonTypeBase01L):
//            <#code#>
//        case .some(.DHCButtonTypeBase01M):
//            <#code#>
//        case .some(.DHCButtonTypeBase02M):
//            <#code#>
//        case .some(.DHCButtonTypeBase03M):
//            <#code#>
//        case .some(.DHCButtonTypeBase04M):
//            <#code#>
//        case .some(.DHCButtonTypeBase01N):
//            <#code#>
//        case .some(.DHCButtonTypeBase01O):
//            <#code#>
//        case .some(.DHCButtonTypeBase01P):
//            <#code#>
//        case .some(.DHCButtonTypeBase01Q):
//            <#code#>
//        case .some(.DHCButtonTypeBase01RB):
//            <#code#>
//        case .some(.DHCButtonTypeBase01S):
//            <#code#>
//        case .some(.DHCButtonTypeBase01T):
//            <#code#>
//        case .some(.DHCButtonTypeBase01U):
//            <#code#>
//        case .some(.DHCButtonTypeBase01V):
//            <#code#>
//        case .some(.DHCButtonTypeBase01W):
//            <#code#>
//        case .some(.DHCButtonTypeBase01Y):
//            <#code#>
//        case .some(.DHCButtonTypeBase01Z):
//            <#code#>
//        case .some(.DHCButtonTypeBase01XA):
//            <#code#>
//        case .some(.DHCButtonTypeBase01DA):
//            <#code#>
//        case .some(.DHCButtonTypeBase01A_New):
//            <#code#>
//        case .some(.DHCButtonTypeBase01AA):
//            <#code#>
//        case .some(.DHCButtonTypeBase01E_New):
//            <#code#>
//        case .some(.DHCButtonTypeBase01RA_New):
//            <#code#>
//        case .some(.DHCButtonTypeBase01RB_New):
//            <#code#>
//        case .some(.DHCButtonTypeBase01YA):
//            <#code#>
//        case .some(.DHCButtonTypeBase01G_New):
//            <#code#>
//        case .some(.DHCButtonTypeBase01U_New):
//            <#code#>
//        case .some(.DHCButtonTypeBase01I_New):
//            <#code#>
//        case .some(.DHCButtonTypeBase01J_New):
//            <#code#>
//        case .some(.DHCButtonTypeBase01H_New):
//            <#code#>
//        case .some(.DHCButtonTypeBase01N_New):
//            <#code#>
//        case .some(.DHCButtonTypeBase01IA):
//            <#code#>
//        case .some(.DHCButtonTypeBase02IA):
//            <#code#>
//        case .some(.DHCButtonTypeBase01NA):
//            <#code#>
//        case .some(.DHCButtonTypeBase02NA):
//            <#code#>
//        case .some(.DHCButtonTypeBase01KA):
//            <#code#>
//        case .some(.DHCButtonTypeBase02KA):
//            <#code#>
//        case .some(.DHCButtonTypeBase01KB):
//            <#code#>
//        case .some(.DHCButtonTypeBase02KB):
//            <#code#>
//        case .some(.DHCButtonTypeBase01KC):
//            <#code#>
//        case .some(.DHCButtonTypeBase02KC):
//            <#code#>
//        case .some(.DHCButtonTypeBase01M_New):
//            <#code#>
//        case .some(.DHCButtonTypeBase02M_New):
//            <#code#>
//        case .some(.DHCButtonTypeBase03M_New):
//            <#code#>
//        case .some(.DHCButtonTypeBase04M_New):
//            <#code#>
//        case .some(.DHCButtonTypeBase01Z_New):
//            <#code#>
//        case .some(.DHCButtonTypeBase01E1):
//            <#code#>
//        case .some(.DHCButtonTypeBase05M):
//            <#code#>
//        case .some(.DHCButtonTypeBase05M_New):
//            <#code#>
//        case .some(.DHCButtonTypeBase02Z_New):
//            <#code#>
//        case .some(.DHCButtonTypeBase01RC_New):
//            <#code#>
//        }
    }

    /*!
     *  @brief 设置按钮描边颜色 light&dark
     *
     *  @param color 描边颜色
     *  @param state 按钮状态
     *
     *  @since 9.0
     */
    func setBorderColor(_ color: UIColor?, for state: UIControl.State) {
        
    }

    func setBorderDarkColor(_ darkColor: UIColor?, for state: UIControl.State) {
    }
    /*!
     *  @brief 设置按钮背景颜色
     *
     *  @param backgroundColor 背景颜色
     *  @param state 按钮状态
     *
     *  @since 9.0
     */
    func setBackgroundColor(_ backgroundColor: UIColor?, for state: UIControl.State) {
        
    }
    func setBackgroundDarkColor(_ backgroundDarkColor: UIColor?, for state: UIControl.State) {
        
    }
    /*!
     *  @brief 设置按钮背景渐变颜色 light&dark
     *
     *  @param colors 颜色数组
     *  @param state 按钮状态
     *
     *  @since 9.0
     */
    func setGradientColors(_ colors: [UIColor]?, for state: UIControl.State) {
        
    }

    func setGradientDarkColors(_ darkColors: [UIColor]?, for state: UIControl.State) {
        
    }
    /*!
     *  @brief 设置按钮投影效果
     *  @author kongleifeng
     *  @param shadowColor 投影颜色
     *  @param shadowOffset 偏移量  (width,height)：width表示X偏移，负数表示往左，正数表示往右；height表示Y偏移，负数表示往上，正数表示往下。不偏移设置为0
     *  @param shadowOpacity 不透明度
     *  @param shadowRadius 模糊半径
     *
     *  @since 8.0
     */
    func shadowColor(_ shadowColor: UIColor?, shadowOffset: CGSize, shadowOpacity: CGFloat, shadowRadius: CGFloat) {
        
    }
    /*!
     *  @brief 设置按钮特殊禁止状态
     *  @author kongleifeng
     *  @param sepcial 启用特殊禁止 默认为No；special 为Yes时启动特殊禁止；
     *  @since 8.0
     */
    func setButtonSpecialDisable(_ sepcial: Bool) {
        
    }
    /*!
     *
     * @brief 设置按钮不同角度效果
     *
     * @param corners 需要添加单独设置的角度 DHCUIRectCornerTopLeft 左上；DHCUIRectCornerTopLeft|DHCUIRectCornerTopRight 左上和右上
     * @param cornerRadius 角度的大小
     * 目前仅支持 DHCButtonTypeBase01XA,ADHCButtonTypeBase01XB 两种类型
     * @since 8.0
     */
    func roundingCorners(_ corners: DHCUIRectCorner, cornerRadius: CGSize) {
        
    }
    /*!
     *  @brief  设置P样式按钮标题
     *
     *  @param arr 文案数组
     *
     *  @since 5.0
     */
    func setSegmentButtonTitles(_ arr: [String]?) {
        
    }
    /*!
     *  @brief  设置P样式选中
     *
     *  @param index 选中下标
     *
     *  @since 5.0
     */
    func setSegmentButtonSelectedIndex(_ index: Int) {
        
    }
    /*!
     *  @brief  设置P样式按钮文案直接的间距 默认24
     *
     *  @param sp 间距
     *
     *  @since 5.0
     */
    func setSegmentButtonSpacing(_ sp: CGFloat) {
        
    }
    /*!
     *  @brief  设置P样式按钮文案font 默认15
     *
     *  @param font
     *
     *  @since 5.0
     */
    func setSegmentButtonTitlesFont(_ font: CGFloat) {
        
    }
    /*!
     *  @brief  获取P样式按钮当前选中下标
     *
     *  @return 当前选中的index
     *
     *  @since 5.0
     */
    func segmentButtonCurrentIndex() -> Int {
        return _index
    }
    /*!
     *  @brief  更新P样式按钮文案
     *
     *  @param index 指定index
     *  @param title 文案
     *
     *  @since 5.0
     */
    func updateTitle(_ title: String?, forSegmentButtonAt index: Int) {
        
    }
    func initViews() {
        if baseType == DHCButtonType.DHCButtonTypeBase01P {
//            if self.titles && self.titles?.count > 0 {
//
//            }
        }
//        if baseType == DHCButtonTypeBase01U {
//            if !selected {
//                layer.borderColor = UIColor.clear.cgColor
//                addDashLayer()
//                dashLayer.strokeColor = borderColorNormal.cgColor
//                lineDashPattern = [NSNumber(value: 3), NSNumber(value: 2)]
//            } else {
//                if dashLayer {
//                    dashLayer.removeFromSuperlayer()
//                }
//            } else if (_baseType == DHCButtonTypeBase01V) {
//                self.bottomLine.frame = CGRectMake(0,CGRectGetHeight(self.frame)-0.5, CGRectGetWidth(self.frame), 0.5);
//            }
//
//        }
    }
    /*!
     *  @brief  iPhone 通用基础按钮库
     *
     *  @param buttonType buttonType 样式类型
     *
     *  @return iPhone 通用基础按钮
     *
     *  @since 4.0
     */
    class func button(withDHCType buttonType: DHCButtonType) -> UIButton? {
//        let button = DHCButton(type: UIButton.ButtonType.custom)
//        let button = DHCButton.init(type: .custom)
        let button = DHCButton(type: .custom)
        button.baseType = buttonType
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true

//        let lim = DHCButtonType.DHCButtonType1
//        var head: DHCButtonType = .DHCButtonType2
//        head = .DHCButtonType2
//        if lim == head {
//              print("一样的")
//        } else {
//             print("不一样")
//        }
        if buttonType == DHCButtonType.DHCButtonType1 {
            var originFrame = button.frame
            originFrame.size.height = 48
            button.frame = originFrame
            button.backgroundColor = .blue

        } else if buttonType == DHCButtonType.DHCButtonType2 || buttonType == DHCButtonType.DHCButtonType3{
            var originFrame = button.frame
            originFrame.size.height = 38
            button.frame = originFrame
            button.backgroundColor = .red
        } else if (buttonType == DHCButtonType.DHCButtonType4 || buttonType == DHCButtonType.DHCButtonType7 || buttonType == DHCButtonType.DHCButtonType8 || buttonType == DHCButtonType.DHCButtonType9) {
            var originFrame = button.frame
            originFrame.size.height = 28
            button.frame = originFrame
            button.backgroundColor = .red
        }
        
        // 监听
        var direction = DHCButtonType.DHCButtonType1 {
            willSet {
                if newValue != direction {
                    print("方向即将发生变化")
                }
            }
            didSet {
                if oldValue != direction {
                    print("方向已经发生变化")
                }
            }
        }
        print("一样的\(direction)")
        return button
    }
    // 是否是老年版
    func getIsElderMode() -> Bool {
        //是否夕阳红老年版elder，elder和light走一个逻辑，elder没有暗黑
        //优先级：canDirectUseElderMode > canSupportAdaptElderMode > App老年版开关
        if canDirectUseElderMode {
            //直接使用老年版UI
            return true
        } else {
            //跟随App老年版开关
            if canSupportAdaptElderMode && isElderModeByRouter() {
                return true
            }
        }
        return false
    }
    // 获取当前的mode
    func isElderModeByRouter() -> Bool {
        //currentMode @1: 长辈版; @0: 标准版;
        let currentMode = 0
        let currentModeNUm = currentMode
        if currentModeNUm == 0 {
            return false
        } else if currentModeNUm == 1 {
            return true
        }
        return false
    }
    
}

