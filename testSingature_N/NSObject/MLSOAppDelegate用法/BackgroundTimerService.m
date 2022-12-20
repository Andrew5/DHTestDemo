//
//  BackgroundTimer.m
//  Demo
//
//  Created by rilakkuma on 2022/12/16.
//  Copyright © 2022 jsun. All rights reserved.
//

#import "BackgroundTimerService.h"

@interface BackgroundTimerService ()

@property (assign, nonatomic) UIBackgroundTaskIdentifier backgroundUpdateTask;
@property (assign, nonatomic) CGFloat number;

@end

@implementation BackgroundTimerService

ML_EXPORT_SERVICE(BackgroundTimer)

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.number = 0.0;
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self beingBackgroundUpdateTask];

    NSTimer * timer = [NSTimer timerWithTimeInterval:1.0
                                       target:self
                                     selector:@selector(timerTicked)
                                     userInfo:nil
                                      repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer
                                         forMode:NSDefaultRunLoopMode];
    // 在这里处理操作。完成后手动调用 endBackgroundUpdateTask
//    [self endBackgroundUpdateTask];
}
- (void) timerTicked
{
    self.number ++;
    NSLog(@"Timer method %lf",self.number);
}
 - (void)beingBackgroundUpdateTask
 {
     self.backgroundUpdateTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
         [self endBackgroundUpdateTask];//如果在规定时间内任务没有完成，会调用这个方法。
     }];
 }
 - (void)endBackgroundUpdateTask
 {
     [[UIApplication sharedApplication] endBackgroundTask: self.backgroundUpdateTask];
     self.backgroundUpdateTask = UIBackgroundTaskInvalid;
 }
@end
