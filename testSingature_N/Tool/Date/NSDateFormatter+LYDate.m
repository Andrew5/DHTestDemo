//
//  LYDefineTime.h
//  LYInfoDemo
//
//  Created by boai on 2022/9/20.
//  时间处理

//iOS-NSDateFormatter格式说明：
//G: 公元时代，例如AD公元
//yy: 年的后2位
//yyyy: 完整年
//MM: 月，显示为1-12
//MMM: 月，显示为英文月份简写,如 Jan
//MMMM: 月，显示为英文月份全称，如 Janualy
//dd: 日，2位数表示，如02
//d: 日，1-2位显示，如 2
//EEE: 简写星期几，如Sun
//EEEE: 全写星期几，如Sunday
//aa: 上下午，AM/PM
//H: 时，24小时制，0-23
//K：时，12小时制，0-11
//m: 分，1-2位
//mm: 分，2位
//s: 秒，1-2位
//ss: 秒，2位
//S: 毫秒
//Z：GMT


#import "NSDateFormatter+LYDate.h"
#import "LYDefineDateFormat.h"

@implementation NSDateFormatter (LYDate)

+ (id)ly_dateFormatter {
    return [[self alloc] init];
}

+ (id)ly_dateFormatterWithFormatString:(NSString *)dateFormatString {
    if (dateFormatString == nil || ![dateFormatString isKindOfClass:[NSString class]] || [dateFormatString isEqualToString:@""]) {
        return nil;
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = dateFormatString;
    
    return dateFormatter;
}

+ (id)ly_dateFormatterWithFormatString:(NSString *)dateFormatString timezoneName:(NSString *)timezoneName {
    NSDateFormatter *dateFormatter = [NSDateFormatter ly_dateFormatterWithFormatString:dateFormatString];
    
    if (timezoneName != nil && [timezoneName isKindOfClass:[NSString class]] && ![timezoneName isEqualToString:@""]) {
        dateFormatter.timeZone = [NSTimeZone timeZoneWithName:timezoneName];
    }
    return dateFormatter;
}

+ (id)ly_dateFormatterWithFormatString:(NSString *)dateFormatString dateStyle:(NSDateFormatterStyle)dateStyle {
    
    NSDateFormatter *dateFormatter = [NSDateFormatter ly_dateFormatterWithFormatString:dateFormatString];

    dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    dateFormatter.dateStyle = dateStyle;
    
    return dateFormatter;
}

+ (id)ly_setupDateFormatterWithYMDHMS {
    return [self ly_dateFormatterWithFormatString:LYDateFormatString_YMDHMS];
}

+ (id)ly_setupDateFormatterWithYMDEHMS {
    return [self ly_dateFormatterWithFormatString:LYDateFormatString_YMDEHMS];
}

+ (id)ly_setupDateFormatterWithYMD {
    return [self ly_dateFormatterWithFormatString:LYDateFormatString_YMD];
}

+ (id)ly_setupDateFormatterWithYM {
    return [self ly_dateFormatterWithFormatString:LYDateFormatString_YM];
}

+ (id)ly_setupDateFormatterWithYY {
    return [self ly_dateFormatterWithFormatString:LYDateFormatString_Y];
}

+ (id)ly_setupDateFormatterWithHM {
    return [self ly_dateFormatterWithFormatString:LYDateFormatString_HM];
}

+ (id)ly_setupDateFormatterWithHMS {
    return [self ly_dateFormatterWithFormatString:LYDateFormatString_YMDHMS];
}


@end
