//
//  DHGlobalContentButton.h
//  testSingature
//
//  Created by jabraknight on 2021/7/26.
//  Copyright ©https://github.com/miniLV/MNFloatBtn All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ContentButtonClick)(UIButton *sender);

@interface DHGlobalContentButton : UIButton
//外部访问当前环境
@property (nonatomic, copy, class)NSString *evnstring;
@property (nonatomic, strong)NSDictionary *environmentMap;

///UAT、SIT、PRO环境对应的网址
@property (nonatomic, copy, class)NSString *HostURL;

//按钮点击事件
@property (nonatomic, copy)ContentButtonClick buttonClick;

- (void)setEnvironmentMap:(NSDictionary *)environmentMap currentEnvir:(NSString *)currentEnvir;

- (void)changeEnvironment;

@end

NS_ASSUME_NONNULL_END
