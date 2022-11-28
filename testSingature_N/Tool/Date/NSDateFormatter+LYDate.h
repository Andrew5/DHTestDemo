//
//  LYDefineTime.h
//  LYInfoDemo
//
//  Created by boai on 2022/9/20.
//  时间处理


#import <Foundation/Foundation.h>

@interface NSDateFormatter (LYDate)

+ (id)ly_dateFormatter;

+ (id)ly_dateFormatterWithFormatString:(NSString *)dateFormatString;

+ (id)ly_dateFormatterWithFormatString:(NSString *)fmtString timezoneName:(NSString *)timezoneName;
+ (id)ly_dateFormatterWithFormatString:(NSString *)dateFormatString dateStyle:(NSDateFormatterStyle)dateStyle;
/**
 格式化：yyyy-MM-dd HH:mm:ss

 @return NSDateFormatter
 */
+ (id)ly_setupDateFormatterWithYMDHMS;

/**
 格式化：yyyy-MM-dd, EEE, HH:mm:ss
 
 @return NSDateFormatter
 */
+ (id)ly_setupDateFormatterWithYMDEHMS;

/**
 格式化：yyyy-MM-dd
 
 @return NSDateFormatter
 */
+ (id)ly_setupDateFormatterWithYMD;

/**
 格式化：yyyy-MM
 
 @return NSDateFormatter
 */
+ (id)ly_setupDateFormatterWithYM;

/**
 格式化：yyyy
 
 @return NSDateFormatter
 */
+ (id)ly_setupDateFormatterWithYY;

/**
 格式化：HM
 
 @return NSDateFormatter
 */
+ (id)ly_setupDateFormatterWithHM;

/**
 格式化：HMS
 
 @return NSDateFormatter
 */
+ (id)ly_setupDateFormatterWithHMS;

@end
