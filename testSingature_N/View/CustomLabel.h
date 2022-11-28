//
//  CustomLabel.h
//  TextAnimate
//
//  Created by 郭毅 on 2021/2/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomLabel : UIView

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, assign) CGAffineTransform textTransform;
@property (nonatomic, assign) CGFloat angle;

@end

NS_ASSUME_NONNULL_END
