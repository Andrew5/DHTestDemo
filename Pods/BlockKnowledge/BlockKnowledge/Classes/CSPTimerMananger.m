//
//  CSPTimerMananger.m
//  xxcb
//
//  Created by xuyi on 2022/6/2.
//

#import "CSPTimerMananger.h"
#import <UIKit/UIKit.h>


@interface CSPTimeInterval ()

@property (nonatomic, assign) NSInteger timeInterval;

+ (instancetype)timeInterval:(NSInteger)timeInterval;

@end


NSString *const CSPTimerNotification = @"CSPTimerNotification";

@interface CSPTimerMananger()

@property (nonatomic, strong) NSTimer *timer;

/// 时间差字典(单位:秒)(使用字典来存放, 支持多列表或多页面使用)
@property (nonatomic, strong) NSMutableDictionary<NSString *, CSPTimeInterval*> *timeIntervalDict;

/// 后台模式使用, 记录进入后台的绝对时间
@property (nonatomic, assign) BOOL backgroudRecord;
@property (nonatomic, assign) CFAbsoluteTime lastTime;
/// 用来计算
@property (nonatomic, assign) NSInteger tempTimeInterval;

@end

@implementation CSPTimerMananger

+ (instancetype)shareManager{
    static dispatch_once_t onceToken;
    static CSPTimerMananger *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[CSPTimerMananger alloc] init];
    });
    
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // 监听进入前台与进入后台的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackgroundNotification) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForegroundNotification) name:UIApplicationWillEnterForegroundNotification object:nil];
        /// 默认间隔为1
        self.timeInterval = 1;
    }
    
    return self;
}

- (void)start {
    // 启动定时器
    [self timer];
    self.tempTimeInterval = 0;
}

- (void)reload {
    // 刷新只要让时间差为1即可
    _timeInterval = 1;
}

- (void)invalidate {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)timerAction {
    // 定时器每次加1
    [self timerActionWithTimeInterval:1];
}

- (void)timerActionWithTimeInterval:(NSInteger)timeInterval {
    [self.timeIntervalDict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, CSPTimeInterval * _Nonnull obj, BOOL * _Nonnull stop) {
        obj.timeInterval += timeInterval;
    }];
    // 发出通知
    self.tempTimeInterval += timeInterval;
    if (self.tempTimeInterval % self.timeInterval == 0) {
        self.tempTimeInterval = 0;
        [[NSNotificationCenter defaultCenter] postNotificationName:CSPTimerNotification object:nil userInfo:nil];
    }
}

- (void)addSourceWithIdentifier:(NSString *)identifier {
    CSPTimeInterval *timeInterval = self.timeIntervalDict[identifier];
    if (timeInterval) {
        timeInterval.timeInterval = 0;
    }else {
        [self.timeIntervalDict setObject:[CSPTimeInterval timeInterval:0] forKey:identifier];
    }
}

- (NSInteger)timeIntervalWithIdentifier:(NSString *)identifier {
    CSPTimeInterval * model = self.timeIntervalDict[identifier];
    return model.timeInterval;
}

- (void)reloadSourceWithIdentifier:(NSString *)identifier {
    CSPTimeInterval * model = self.timeIntervalDict[identifier];
    model.timeInterval = 0;
}

- (void)reloadAllSource {
    [self.timeIntervalDict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, CSPTimeInterval * _Nonnull obj, BOOL * _Nonnull stop) {
        obj.timeInterval = 0;
    }];
}

- (void)removeSourceWithIdentifier:(NSString *)identifier {
    [self.timeIntervalDict removeObjectForKey:identifier];
}

- (void)removeAllSource {
    [self.timeIntervalDict removeAllObjects];
}

- (void)applicationDidEnterBackgroundNotification {
    self.backgroudRecord = (_timer != nil);
    if (self.backgroudRecord) {
        self.lastTime = CFAbsoluteTimeGetCurrent();
        [self invalidate];
    }
}

- (void)applicationWillEnterForegroundNotification {
    if (self.backgroudRecord) {
        CFAbsoluteTime timeInterval = CFAbsoluteTimeGetCurrent() - self.lastTime;
        // 取整
        [self timerActionWithTimeInterval:(NSInteger)timeInterval];
        [self start];
    }
}

- (NSTimer *)timer {
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

- (NSMutableDictionary<NSString *, CSPTimeInterval*> *)timeIntervalDict {
    if (!_timeIntervalDict) {
        _timeIntervalDict = [NSMutableDictionary dictionary];
    }
    return _timeIntervalDict;
}


@end


@implementation CSPTimeInterval

+ (instancetype)timeInterval:(NSInteger)timeInterval {
    CSPTimeInterval *object = [CSPTimeInterval new];
    object.timeInterval = timeInterval;
    return object;
}

@end

