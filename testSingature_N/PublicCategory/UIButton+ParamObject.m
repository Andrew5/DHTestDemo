//
//  UIButton+ParamObject.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/12/5.
//

#import "UIButton+ParamObject.h"
#import <objc/runtime.h>

@implementation UIButton (ParamObject)
- (void)setInfo:(NSDictionary *)info {
    objc_setAssociatedObject(self, @"info", info, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)info {
    return objc_getAssociatedObject(self, @"info");
}
@end
