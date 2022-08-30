//
//  CSPTimerMananger.h
//  xxcb
//
//  Created by xuyi on 2022/6/2.
//

#import <Foundation/Foundation.h>


@interface CSPTimeInterval : NSObject
@end


/** 倒计时的通知名 */
extern NSString *const CSPTimerNotification;

@interface CSPTimerMananger : NSObject

/** 使用单例 */
+ (instancetype)shareManager;

/** 开始倒计时 */
- (void)start;

/** 停止倒计时 */
- (void)invalidate;



/** 时间差(单位:秒) */
@property (nonatomic, assign) NSInteger timeInterval;

/** 刷新倒计时 */
- (void)reload;



/** 添加倒计时源 */
- (void)addSourceWithIdentifier:(NSString *)identifier;

/** 获取时间差 */
- (NSInteger)timeIntervalWithIdentifier:(NSString *)identifier;

/** 刷新倒计时源 */
- (void)reloadSourceWithIdentifier:(NSString *)identifier;

/** 刷新所有倒计时源 */
- (void)reloadAllSource;

/** 清除倒计时源 */
- (void)removeSourceWithIdentifier:(NSString *)identifier;

/** 清除所有倒计时源 */
- (void)removeAllSource;

@end


