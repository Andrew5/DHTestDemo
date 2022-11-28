//
//  LYDefineFrame.h
//  LYInfoDemo
//
//  Created by boai on 2022/9/20.
//  Frame 相关便捷方法

#ifndef LYDefineFrame_h
#define LYDefineFrame_h

/// 屏幕宽度
CG_INLINE CGFloat LYScreenWidth() {
    return [UIScreen mainScreen].bounds.size.width;
}

/// 屏幕高度
CG_INLINE CGFloat LYScreenHeight() {
    return [UIScreen mainScreen].bounds.size.height;
}

/// 屏幕安全距离
CG_INLINE UIEdgeInsets LYSafeAreaInsets(void) {
    UIEdgeInsets safeAreaInsets = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        safeAreaInsets = [[[[UIApplication sharedApplication] delegate] window] safeAreaInsets];
    }
    return safeAreaInsets;
}

/// 是否是 iPhoneX
CG_INLINE BOOL LYIsIphoneX() {
    return LYSafeAreaInsets().bottom > 0;
}

/// StatusBar 高度
CG_INLINE CGFloat LYStatusBarHeight() {
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    if (@available(iOS 13.0, *)) {
        UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
        if (statusBarManager && statusBarManager.statusBarFrame.size.height > 0) {
            statusBarHeight = statusBarManager.statusBarFrame.size.height;
        }
    }
    return statusBarHeight;
}

/// NavigationBar 高度
CG_INLINE CGFloat LYNavigationBarHeight() {
    return 44.0;
}

/// StatusBar+NavigationBar 高度
CG_INLINE CGFloat LYStatusBarAndNavigationBarHeight() {
    return LYStatusBarHeight() + LYNavigationBarHeight();
}

/// TabbarHeight 高度
CG_INLINE CGFloat LYTabbarHeight() {
    return 49.0 + LYSafeAreaInsets().bottom;
}


/*! 屏幕适配
 5S 标准屏幕：320 * 568
 iPhone 7 屏幕：375 * 667
 */
/// 基准屏幕宽度
CG_INLINE CGFloat LYBaseScreenWidth() {
    return 375.0;
}

/// 基准屏幕高度
CG_INLINE CGFloat LYBaseScreenHeight() {
    return 667.0;
}

/// 根据 view 在屏幕的宽度 做屏幕适配
CG_INLINE CGFloat
LYFrameScaleWidth(CGFloat uiWidth) {
    // 100 * 375/375; 40 * 375/375;
    CGFloat result = uiWidth * (LYScreenWidth() / LYBaseScreenWidth());
    return result;
}

/// 根据 view 在屏幕的宽度和 UI 的宽高做屏幕适配
CG_INLINE CGFloat
LYFrameScaleHeight(CGFloat viewWidth, CGFloat uiWidth, CGFloat uiHeight) {
    // 100 * 40/100;
    CGFloat result = viewWidth * (uiHeight / uiWidth);
    return result;
}

/// 根据 view 在屏幕的宽度 UI 的高（按 width 算一样）做屏幕适配
CG_INLINE CGFloat
LYFrameScaleCustuomHeight(CGFloat viewWidth, CGFloat uiHeight) {
    // 100 * 40/100;
    CGFloat result = LYFrameScaleHeight(viewWidth, LYBaseScreenWidth(), uiHeight);
    return result;
}

#pragma mark - 根据文字内容、高度和字体返回 宽度
CG_INLINE CGFloat
LYGetLabelWidthWithTextAndFont(NSString *text, CGFloat height, UIFont *font){
    CGSize size = CGSizeMake(MAXFLOAT, height);
    NSMutableDictionary *attributesDic = @{}.mutableCopy;
    if (font) {
        attributesDic[NSFontAttributeName] = font;
    }

    CGRect frame = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading attributes:attributesDic context:nil];
    
    return frame.size.width;
}

CG_INLINE CGFloat
LYGetLabelHeightWithTextAndFont(NSString *text, CGFloat width, UIFont *font){
    CGSize size = CGSizeMake(width, MAXFLOAT);
    NSMutableDictionary *attributesDic = @{}.mutableCopy;
    if (font) {
        attributesDic[NSFontAttributeName] = font;
    }

    CGRect frame = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading attributes:attributesDic context:nil];
    
    return frame.size.height;
}

/// 根据 NSAttributedString 文字内容、高度和字体返回 宽度
CG_INLINE CGFloat
LYGetLabelWidthWithNSAttributedTextAndFont(NSAttributedString *text, CGFloat height, UIFont *font){
    CGSize size = CGSizeMake(MAXFLOAT, height);
    CGRect frame = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    return frame.size.width;
}

#endif /* LYDefineFrame_h */
