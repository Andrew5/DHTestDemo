//
//  JDBMAddressSwitch.h
//  JDBMWorkbenchModule
//
//  Created by ext.wangdongdong3 on 2022/6/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JDBMAddressSwitch : UIControl

/// 开关状态
@property (nonatomic, assign) BOOL isOn;
/// 关闭背景色
@property (nonatomic, strong) UIColor *offColor;
/// 打开背景色
@property (nonatomic, strong) UIColor *onColor;
/// 滑块关闭样式
@property (nonatomic, strong) UIImage *thumbOffImage;
/// 滑块打开样式
@property (nonatomic, strong) UIImage *thumbOnImage;
/*
 使用方法：
 /// 设置默认地址开关
 - (JDBMAddressSwitch *)defaultAddressSwitch {
     if (!_defaultAddressSwitch) {
         _defaultAddressSwitch = [JDBMAddressSwitch new];
         _defaultAddressSwitch.thumbOffImage = [UIImage imageNamed:@"editAddress_set_default"];
         [_defaultAddressSwitch addTarget:self action:@selector(setDefaultAddressSwitchAction:) forControlEvents:UIControlEventValueChanged];
     }
     return _defaultAddressSwitch;
 }
 - (void)setDefaultAddressSwitchAction:(JDBMAddressSwitch *)aSwitch {
     NSLog(@"我被切换了");
 }
 */
@end

NS_ASSUME_NONNULL_END
