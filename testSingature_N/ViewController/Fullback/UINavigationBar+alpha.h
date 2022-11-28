//
//  UINavigationBar+alpha.h
//  testSingature_N
//
//  Created by rilakkuma on 2022/10/30.
//


#import <UIKit/UIKit.h>

@interface UINavigationBar (alpha)
- (void)DH_setBackgroundColor:(UIColor *)backgroundColor;
- (UIColor *)DH_getBackgroundColor;
- (void)DH_setContentAlpha:(CGFloat)alpha;
- (void)DH_setTranslationY:(CGFloat)translationY;
- (void)DH_reset;
@end
