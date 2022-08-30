//
//  UIView+UIScreenDisplaying.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/8/21.
//

#import "UIView+UIScreenDisplaying.h"

@implementation UIView (UIScreenDisplaying)
//判断View是否显示在屏幕上
- (BOOL)isDisplayedInScreen {
    if (self == nil) {
        return FALSE;
    }
    CGRect screenRect = [UIScreen mainScreen].bounds;
    //转换view对应window的Rect
    CGRect rect = [self convertRect:self.frame fromView:nil];
    if(CGRectIsEmpty(rect) || CGRectIsNull(rect)){
        return FALSE;
    }
    //若view 隐藏
    if(self.hidden){
        return false;
    }
    //若没有superView
    if(self.superview == nil){
        return false;
    }
    //若size 为CGRectZero
    if(CGSizeEqualToSize(rect.size, CGSizeZero)){
        return false;
    }
    //获取 该view 与window 交叉的Rect
    CGRect intersectionRect = CGRectIntersection(rect, screenRect);
    if(CGRectIsEmpty(intersectionRect) || CGRectIsNull(intersectionRect)){
        return false;
    }
    return true;
}

@end
