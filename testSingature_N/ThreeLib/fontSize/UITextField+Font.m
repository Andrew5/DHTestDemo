//
//  UITextField+Font.m
//
//  Created by ljf on 2022/6/16.
//  Copyright ljf. All rights reserved.
//

#import "UITextField+Font.h"
#import <objc/runtime.h>
#import "FontConfig.h"

@implementation UITextField (Font)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzledSel:@selector(setFont:) withSel:@selector(swizzled_setFont:)];
        [self swizzledSel:@selector(awakeFromNib) withSel:@selector(swizzled_awakeFromNib)];
    });
}

+ (void)swizzledSel:(SEL)originalSelector withSel:(SEL)swizzledSelector{
    Class class = [self class];
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    if (!class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    } else {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
}

- (void)swizzled_setFont:(UIFont *)font{
    UIFont *newFont = [FontConfig getScaleFont:font];
    [self swizzled_setFont:newFont];
}

- (void)swizzled_awakeFromNib {
    self.font = [FontConfig getScaleFont:self.font];
    [self swizzled_awakeFromNib];
}

@end
