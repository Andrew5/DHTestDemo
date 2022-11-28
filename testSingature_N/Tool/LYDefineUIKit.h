//
//  LYDefineUIKit.h
//  LYInfoDemo
//
//  Created by boai on 2022/9/20.
//  UIKit 相关便捷方法

#ifndef LYDefineUIKit_h
#define LYDefineUIKit_h


/// 获取当前的 Application
CG_INLINE UIApplication * LYApplication() {
    return UIApplication.sharedApplication;
}

/// 获取当前的 window
CG_INLINE UIWindow * LYWindow() {
    return LYApplication().delegate.window;
}

/// 获取当前的 keyWindow
CG_INLINE UIWindow * LYKeyWindow() {
    return LYApplication().keyWindow;
}

/// 获取当前的 rootViewController
CG_INLINE UIViewController * LYRootViewController() {
    return LYKeyWindow().rootViewController;
}

/// 获取根视图
CG_INLINE UIViewController * LYCurrentViewControllerWith(UIViewController *rootVC) {
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = LYCurrentViewControllerWith([(UITabBarController *)rootVC selectedViewController]);
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = LYCurrentViewControllerWith([(UINavigationController *)rootVC visibleViewController]);
    } else if ([rootVC isKindOfClass:[UIAlertController class]]){
        return rootVC;
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}

/// 获取当前屏幕的 ViewController
CG_INLINE UIViewController * LYCurrentViewController() {
    return LYCurrentViewControllerWith(LYRootViewController());
}


#pragma mark - View

/// 移除 view 所有 subviews
CG_INLINE void LYRemoveAllSubviews(UIView * _Nonnull view) {
    [view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

/// 给 view 设置圆角、边线
CG_INLINE void LYSetViewCornerRadiusAndBorder(UIView * _Nonnull view, CGFloat cornerRadius, CGFloat borderWidth, UIColor * _Nullable  borderColor) {
    view.layer.cornerRadius = cornerRadius;
    view.layer.borderWidth = borderWidth;
    view.layer.borderColor = borderColor.CGColor;
    view.layer.masksToBounds = YES;
}

/// 给 view 设置圆角
CG_INLINE void LYSetViewCornerRadius(UIView * _Nonnull view, CGFloat cornerRadius) {
    LYSetViewCornerRadiusAndBorder(view, cornerRadius, 0, nil);
}
 
/// UIBezierPath 圆角
CG_INLINE void LYSetBezierCornerRadius(UIView * _Nonnull view, UIRectCorner corners, CGFloat rads) {
    [view layoutIfNeeded];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(rads, rads)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
};

/// 创建一个纯颜色图片（color、size、alpha）
CG_INLINE UIImage * _Nullable LYCreateImageWithColorAndSizeAndAlpha(UIColor * _Nullable color, CGSize size, CGFloat alpha) {
    if (!color || size.width <= 0 || size.height <= 0) {
        return nil;
    }
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextSetAlpha(context, alpha);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/// 创建一个纯颜色图片（color、size）
CG_INLINE UIImage * _Nullable LYCreateImageWithColorAndSize(UIColor * _Nullable color, CGSize size) {
    return LYCreateImageWithColorAndSizeAndAlpha(color, size, 1.0);
}

/// 创建一个纯颜色图片（color）
CG_INLINE UIImage * _Nullable LYCreateImageWithColor(UIColor * _Nullable color) {
    return LYCreateImageWithColorAndSize(color, CGSizeMake(1, 1));
}


#endif /* LYDefineUIKit_h */
