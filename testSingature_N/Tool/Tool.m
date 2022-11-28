//
//  Tool.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/10/18.
//

#import "Tool.h"
#import <UIKit/UIKit.h>

UIColor *getColorFromHex(NSString *hexColor) {
    
    if (hexColor == nil) {
        return nil;
    }
    NSUInteger strLen = [hexColor length];
    if ( strLen < 6 || strLen > 7) {
        return nil;
    }
    
    unsigned int red, green, blue;
    NSRange range;
    range.length = 2;
    
    int offset = 1;
    if ( 6 == strLen )
        offset = 0;
    
    range.location = offset;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    range.location = offset + 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    range.location = offset + 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:1.0f];
}
