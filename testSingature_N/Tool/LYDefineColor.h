//
//  LYDefineColor.h
//  LYInfoDemo
//
//  Created by boai on 2022/9/20.
//  Color 相关便捷方法

#ifndef LYDefineColor_h
#define LYDefineColor_h

#pragma mark - 十六进制创建颜色
#define LYColorWithHex(hexValue) [UIColor \
colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0xFF00) >> 8))/255.0 \
blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

#define LYColorWithHexAlpha(hexValue,a) [UIColor \
colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0xFF00) >> 8))/255.0 \
blue:((float)(hexValue & 0xFF))/255.0 alpha:(a)]

#pragma mark - RGB创建颜色
#define LYColorWithRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kColorWithRGBA(r, g, b, a) [UIColor colorWithRed:(float)r / 255.0f green:(float)g / 255.0f blue:(float)b / 255.0f alpha:a]

// 随机rgb颜色
CG_INLINE UIColor *
LYColorRandom(){
    return kColorWithRGB(arc4random_uniform(0xffffff));
}

#endif /* LYDefineColor_h */
