//
//  LYDefineTime.h
//  LYInfoDemo
//
//  Created by boai on 2022/9/20.
//  时间处理

#import <Foundation/Foundation.h>

@interface NSDate (LYDefine)

@property (nonatomic, readonly) NSInteger year;
@property (nonatomic, readonly) NSInteger month;
@property (nonatomic, readonly) NSInteger day;
@property (nonatomic, readonly) NSInteger nearestHour;
@property (nonatomic, readonly) NSInteger hour;
@property (nonatomic, readonly) NSInteger minute;
@property (nonatomic, readonly) NSInteger second;
@property (nonatomic, readonly) NSInteger nanosecond;
@property (nonatomic, readonly) NSInteger weekday;
//PRC 中国
@property (nonatomic, readonly) NSInteger weekdayPRC;
@property (nonatomic, readonly) NSInteger weekdayOrdinal;
@property (nonatomic, readonly) NSInteger weekOfMonth;
@property (nonatomic, readonly) NSInteger weekOfYear;
@property (nonatomic, readonly) NSInteger yearForWeekOfYear;
@property (nonatomic, readonly) NSInteger quarter;

/**
 确定每个月是否为闰月
 */
@property (nonatomic, readonly) BOOL isLeapMonth;

/**
 确定每个月是否为闰年
 */
@property (nonatomic, readonly) BOOL isLeapYear;

/**
 是否是今天
 */
@property (nonatomic, readonly) BOOL isToday;

/**
 是否是昨天
 */
@property (nonatomic, readonly) BOOL isYesterday;
@property (nonatomic, readonly) BOOL isTomorrow;
@property (nonatomic, readonly) BOOL isThisWeek;
@property (nonatomic, readonly) BOOL isNextWeek;
@property (nonatomic, readonly) BOOL isLastWeek;
@property (nonatomic, readonly) BOOL isThisMonth;
@property (nonatomic, readonly) BOOL isThisYear;
@property (nonatomic, readonly) BOOL isNextYear;
@property (nonatomic, readonly) BOOL isLastYear;
@property (nonatomic, readonly) BOOL isInFuture;
@property (nonatomic, readonly) BOOL isInPast;

@property (nonatomic, readonly) BOOL isTypicallyWorkday;
@property (nonatomic, readonly) BOOL isTypicallyWeekend;


/*!
 *  计算上报时间差: 几分钟前，几天前，传入 NSDate，自动解析
 *
 *  @return 计算上报时间差: 几分钟前，几天前
 */
- (NSString *)ly_dateFormattedWithDate;

/*!
 *  计算上报时间差: 几分钟前，几天前，传入 NSString 类型的 date，如：@"2017-04-25 11:18:01"，自动解析
 *
 *  @return 计算上报时间差: 几分钟前，几天前
 */
+ (NSString *)ly_dateCreated_at:(NSString *)date;

/*!
 *  获得一个比当前时间大n年的时间，格式为 yyyy-MM-dd
 */
+ (NSString *)ly_dateStringAfterYears:(NSInteger)count;
+ (NSDate *)ly_dateAfterYears:(NSInteger)count;

/*!
 *  返回一个只有年月日的时间
 */
- (NSDate *)ly_dateWithYMD;

- (NSDate *)ly_dateWithYM;

/*!
 *  获得与当前时间的差距
 */
- (NSDateComponents *)ly_dateDeltaWithNow;

/**
 字符串转日期格式
 
 @param dateString 字符串日期
 @param formatString formatString description
 @return NSDate
 */
+ (NSDate *)ly_dateStringToDateString:(NSString *)dateString
                         formatString:(NSString *)formatString;

/**
 将世界时间转化为中国区时间
 
 @param date 需要转换的日期
 @return NSDate
 */
+ (NSDate *)ly_dateWorldTimeToChinaTime:(NSDate *)date;

/**
 距离当前的时间间隔描述
 
 @return 时间间隔描述
 */
- (NSString *)ly_dateTimeIntervalDescription;

/**
 精确到分钟的日期描述
 
 @return 日期描述
 */
- (NSString *)ly_dateMinuteDescription;

/**
 标准时间日期描述
 
 @return 标准时间日期描述
 */
- (NSString *)ly_dateFormattedTime;

/**
 当前日期 距离 1970 时间间隔毫秒
 
 @return 当前日期 距离 1970 时间间隔毫秒
 */
- (double)ly_dateTimeIntervalSince1970InMilliSecond;

/**
 距离 时间间隔毫秒 后的日期
 
 @param timeIntervalInMilliSecond 时间间隔毫秒
 @return 距离 时间间隔毫秒 后的日期
 */
+ (NSDate *)ly_dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond;

/**
 时间间隔格式化
 
 @param time 时间间隔
 @return 时间格式化
 */
+ (NSString *)ly_dateFormattedTimeFromTimeInterval:(long long)time;

#pragma mark UTC
//UTC世界统一时间
- (NSNumber *)ly_dateGetUtcTimeIntervalSince1970;
- (NSNumber *)ly_dateGetUtcTimeIntervalIntSince1970;
- (NSString *)ly_dateTimeIntervalStringSince1970;

#pragma mark - 距离当前日期最近的日期
+ (NSDate *)ly_dateTomorrow;
+ (NSDate *)ly_dateYesterday;
+ (NSDate *)ly_dateWithDaysFromNow:(NSInteger)days;
+ (NSDate *)ly_dateWithDaysBeforeNow:(NSInteger)days;
+ (NSDate *)ly_dateWithHoursFromNow:(NSInteger)dHours;
+ (NSDate *)ly_dateWithHoursBeforeNow:(NSInteger)dHours;
+ (NSDate *)ly_dateWithMinutesFromNow:(NSInteger)dMinutes;
+ (NSDate *)ly_dateWithMinutesBeforeNow:(NSInteger)dMinutes;

#pragma mark - 比较日期
- (BOOL)ly_dateIsEqualToDateIgnoringTime:(NSDate *)aDate;
- (BOOL)ly_dateIsSameWeekAsDate:(NSDate *)aDate;
- (BOOL)ly_dateIsSameMonthAsDate:(NSDate *)aDate;
- (BOOL)ly_dateIsSameYearAsDate:(NSDate *)aDate;
- (BOOL)ly_dateIsEarlierThanDate:(NSDate *)aDate;
- (BOOL)ly_dateIsLaterThanDate:(NSDate *)aDate;

#pragma mark - 调整日期
- (NSDate *)ly_dateByAddingDays:(NSInteger)dDays;
- (NSDate *)ly_dateBySubtractingDays:(NSInteger)dDays;
- (NSDate *)ly_dateByAddingHours:(NSInteger)dHours;
- (NSDate *)ly_dateBySubtractingHours:(NSInteger)dHours;
- (NSDate *)ly_dateByAddingMinutes:(NSInteger)dMinutes;
- (NSDate *)ly_dateBySubtractingMinutes:(NSInteger)dMinutes;
- (NSDate *)ly_dateAtStartOfDay;
- (NSDateComponents *)ly_dateComponentsWithOffsetFromDate:(NSDate *)aDate;
- (NSDateComponents *)ly_dateComponentsWithOffsetToDate:(NSDate *)aDate;

#pragma mark - 时间间隔
- (NSInteger)ly_dateMinutesAfterDate:(NSDate *)aDate;
- (NSInteger)ly_dateMinutesBeforeDate:(NSDate *)aDate;
- (NSInteger)ly_dateHoursAfterDate:(NSDate *)aDate;
- (NSInteger)ly_dateHoursBeforeDate:(NSDate *)aDate;
- (NSInteger)ly_dateDaysAfterDate:(NSDate *)aDate;
- (NSInteger)ly_dateDaysBeforeDate:(NSDate *)aDate;
- (NSInteger)ly_dateDistanceInDaysToDate:(NSDate *)anotherDate;
/**
 多少天之后
 */
- (NSDate *)ly_dateGetAfterYear:(int)year OrMonth:(int)month OrDay:(int)day;

#pragma mark - 一年有多少周
+ (NSString *)ly_dateGetWeekInyearOrMouth:(BOOL)inYear WithDate:(NSDate *)date;
// 2015、2009、004、1998 这四年是 53 周（目前已知），其余均是52周
+ (NSInteger)ly_dateGetWeekNumbersOfYear:(NSInteger)year;

#pragma mark - 当月有多少天
+ (NSInteger)ly_dateTotaldaysInMonth:(NSDate *)date;

+ (NSInteger)ly_dateGetDifferenceBySmallDate:(NSDate *)smallDate bigDate:(NSDate *)bigDate;

@end

/**
 *  中国农历
 */

@interface NSDate (LunarCalendar)

/**
 * 例如 : 2016丙申年四月初一
 */

- (NSInteger)lunarShortYear;  // 农历年份,数字表示  2016

- (NSString *)lunarLongYear;  // 农历年份,干支表示  丙申年

- (NSInteger)lunarShortMonth; // 农历月份,数字表示  4

- (NSString *)lunarLongMonth; // 农历月份,汉字表示  四月

- (NSInteger)lunarShortDay;   // 农历日期,数字表示  1

- (NSString *)lunarLongDay;   // 农历日期,汉字表示  初一

- (NSString *)lunarSolarTerms;// 农历节气 (立春 雨水 惊蛰 春分...)

/** 传入阳历的年月日返回当天的农历节气 */
+ (NSString *)getLunarSolarTermsWithYear:(int)iYear Month:(int)iMonth Day:(int)iDay;

@end
