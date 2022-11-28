//
//  UIViewController+DHFullCallBack.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/10/30.
//

#import "UIViewController+DHFullCallBack.h"
#import <objc/runtime.h>

@implementation UIViewController (DHFullCallBack)
- (void)setCallBackBlock:(CallBackBlock)callBackBlock {
    objc_setAssociatedObject(self, @selector(callBackBlock), callBackBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (CallBackBlock)callBackBlock {
    return objc_getAssociatedObject(self, _cmd);
}
@end
