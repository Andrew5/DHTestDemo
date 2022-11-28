//
//  HMCustomSwitch.h
//  TestDemo
//
//  Created by jabraknight on 2020/12/21.
//  Copyright © 2020 黄定师. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HMCustomSwitch : UISlider
{
    BOOL on;
    UIColor *tintColor;
    UIView *clippingView;
    UILabel *rightLabel;
    UILabel *leftLabel;
      
    // private member
    BOOL m_touchedSelf;
}
@property(nonatomic,getter=isOn) BOOL on;
@property (nonatomic,retain) UIColor *tintColor;
@property (nonatomic,retain) UIView *clippingView;
@property (nonatomic,retain) UILabel *rightLabel;
@property (nonatomic,retain) UILabel *leftLabel;
  
+ (HMCustomSwitch *) switchWithLeftText: (NSString *) tag1 andRight: (NSString *) tag2;
  
- (void)setOn:(BOOL)on animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
