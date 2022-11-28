//
//  FontConfig.m
//
//  Created by ljf on 2022/6/16.
//  Copyright ljf. All rights reserved.
//

#import "FontConfig.h"

@implementation FontConfig

+ (CGFloat)getScaleFontSize:(CGFloat)fontSize{
    fontSize = fontSize + 2;
    return fontSize;
}

+ (UIFont *)getScaleFont:(UIFont *)font{
    UIFont *newFont = font;
    newFont = [font fontWithSize:[FontConfig getScaleFontSize:font.pointSize]];
    return newFont;
}

@end
