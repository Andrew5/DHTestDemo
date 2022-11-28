//
//  UIBarButtonItem+addition.h
//  testSingature_N
//
//  Created by rilakkuma on 2022/10/30.
//

#import <UIKit/UIKit.h>
@interface FullItemView : UIView

@property(nonatomic, strong) UIButton *btn;
@property(nonatomic, strong) UILabel  *titleLabel;
@end

@interface UIBarButtonItem (addition)

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title
                            target:(id)target
                            action:(SEL)action;

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon
                         highIcon:(NSString *)highIcon
                           target:(id)target
                           action:(SEL)action;

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon
                         highIcon:(NSString *)highIcon
                            title:(NSString *)title
                           target:(id)target
                           action:(SEL)action;
@end
