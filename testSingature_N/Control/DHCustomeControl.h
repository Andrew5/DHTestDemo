//
//  DHButtonControl.h
//  testSingature
//
//  Created by Rillakkuma on 2022/6/17.
//  Copyright © 2022 Jabraknight. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DHCustomeControl : UIControl
@property(nonatomic,strong)UIImageView *contentImageView;
@property(nonatomic,strong)UILabel *contentLabel;
- (instancetype)initWithFrame:(CGRect)frame centerInset:(CGFloat)centerInset updownInset:(CGFloat)updownInset imageName:(NSString *)imageName labelString:(NSString *)labelString labelFont:(CGFloat)font;

@end

NS_ASSUME_NONNULL_END
