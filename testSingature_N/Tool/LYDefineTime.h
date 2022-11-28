//
//  LYDefineTime.h
//  LYInfoDemo
//
//  Created by boai on 2022/9/20.
//  时间处理

#ifndef LYDefineTime_h
#define LYDefineTime_h

#import "NSDate+LYDate.h"
#import "LYDefineDateFormat.h"

/**
 当前日期
 
 @return 当前日期
 */
CG_INLINE NSDate * LYCurrentDate(){
    return [NSDate date];
}

/**
 当前日历
 
 @return 当前日历
 */
CG_INLINE NSCalendar * LYCurrentCalendar(){
    return [NSCalendar currentCalendar];
}

/**
 当前时间【year】
 
 @return 当前时间【year】
 */
CG_INLINE NSInteger LYCurrentYear(){
    return LYCurrentDate().year;
}

/**
 当前时间【month】
 
 @return 当前时间【month】
 */
CG_INLINE NSInteger LYCurrentMonth(void){
    return LYCurrentDate().month;
}

/**
 当前时间【day】
 
 @return 当前时间【day】
 */
CG_INLINE NSInteger LYCurrentDay(void){
    return LYCurrentDate().day;
}

/**
 当前时间【hour】
 
 @return 当前时间【hour】
 */
CG_INLINE NSInteger LYCurrentHour(void){
    return LYCurrentDate().hour;
}

/**
 当前时间【minute】
 
 @return 当前时间【minute】
 */
CG_INLINE NSInteger LYCurrentMinute(void){
    return LYCurrentDate().minute;
}

/*!
 *  根据日期提取当前 星期几【返回 周一...周日】
 *  @param date 需要提取的日期
 *  @return 返回 周一...周日
 */
CG_INLINE NSString * LYCurrentWeekday(NSDate *date){
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    
    return [weekdays objectAtIndex:theComponents.weekday];
}

/**
 获取系统当前日期和时间 【自定义 formatString】
 
 @param formatString formatString
 @return 系统当前日期和时间
 */
CG_INLINE NSString * LYGetCurrentDateWithFormatString(NSString *formatString) {
    //获得系统日期
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:formatString];
    
    NSString *resultString = [dateformatter stringFromDate:LYCurrentDate()];
    return resultString;
}

/**
 当前时间【YMDHMS】
 
 @return 当前时间【YMDHMS】
 */
CG_INLINE NSString *
LYDefine_Current_DateYMDHMS(void){
    return LYGetCurrentDateWithFormatString(LYDateFormatString_YMDHMS);
}

/// 获取当前时间戳
CG_INLINE NSString * LYGetCurrentTimeInterval() {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    NSString *timeIntervalStr = [NSString stringWithFormat:@"%0.f", timeInterval];
    return timeIntervalStr;
}

/// 获取当前时间戳（毫秒）
CG_INLINE NSString * LYGetCurrentMillisecondTimeInterval() {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    NSString *timeIntervalStr = [NSString stringWithFormat:@"%0.f", timeInterval * 1000];
    return timeIntervalStr;
}

/// 获取毫秒级的时间
CG_INLINE NSString * LYGetDateForMillisecondTimestamp(NSString *timestamp) {
    NSTimeInterval interval = [timestamp doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Beijing"]];
    NSString *dateString = [formatter stringFromDate:date];
    NSLog(@"时间戳对应的时间是:%@", dateString);
    return dateString;
}

/// 获取两个时间戳间隔多少天
CG_INLINE NSUInteger LYGetComponentDay(NSString *start, NSString *end) {
    NSDate *dates = [NSDate dateWithTimeIntervalSince1970:start.integerValue];
    NSDate *datee = [NSDate dateWithTimeIntervalSince1970:end.integerValue];
    
    NSDateFormatter *temp = [[NSDateFormatter alloc] init];
    [temp setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *stDt = [temp dateFromString:[temp stringFromDate:dates]];
    NSDate *endDt = [temp dateFromString:[temp stringFromDate:datee]];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:stDt];
    stDt = [stDt dateByAddingTimeInterval:interval];
    
    interval = [zone secondsFromGMTForDate:endDt];
    endDt = [endDt dateByAddingTimeInterval:interval];
    
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    
    unsigned int unitFlags = NSCalendarUnitDay | NSCalendarUnitMonth;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:stDt toDate:endDt options:0];
    
    return [comps day];
}

#endif /* LYDefineTime_h */
