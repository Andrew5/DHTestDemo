//
//  FontConfig.h
//
//  Created by ljf on 2022/6/16.
//  Copyright ljf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FontConfig : NSObject

+ (CGFloat)getScaleFontSize:(CGFloat)fontSize;

+ (UIFont *)getScaleFont:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
