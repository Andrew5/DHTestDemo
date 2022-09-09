//
//  AppDelegate.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/8/20.
//

#import "AppDelegate.h"
#import "QDExceptionHandler.h"
#import "DHOutOfMemoryManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //获取异常
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
    InstallSignalHandler();//信号量截断
    InstallUncaughtExceptionHandler();
    [[DHOutOfMemoryManager sharedInstance] beginMonitoringMemoryEventsWithHandler:^(BOOL wasInForeground) {
        if (wasInForeground) {
            //report
        }
    }];
    /// 创建observer
    CFRunLoopObserverRef ob = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"----监听到RunLoop状态发生改变---%zd-%@",activity,observer);
        /*
         上面的 Source/Timer/Observer 被统称为 mode item，一个item可以被同时加入多个mode。但一个item被重复加入同一个mode时是不会有效果的。如果一个mode中一个item 都没有（只有Observer也不行），则 RunLoop 会直接退出，不进入循环。
         */
        if (activity == kCFRunLoopEntry) {
            NSLog(@"即将处理runloop");
        }
        else if (activity == kCFRunLoopBeforeTimers) {
            NSLog(@"即将处理timer");
        }
        else if (activity == kCFRunLoopBeforeSources) {
            NSLog(@"即将处理Sources");
        }
        else if (activity == kCFRunLoopBeforeWaiting) {
            NSLog(@"即将进入休眠");
        }
        else if (activity == kCFRunLoopAfterWaiting) {
            NSLog(@"从休眠中唤醒loop");
        }
        else if (activity == kCFRunLoopExit) {
            NSLog(@"即将退出");
        }
    });
    // 添加观察者：监听RunLoop的状态
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), ob, kCFRunLoopDefaultMode);
    return YES;
}

/**
 *  发生异常时回调
 *  @param exception 异常信息
 *  @return 返回需上报记录，随异常上报一起上报
 */
- (NSString *__nullable)attachmentForException:(NSException *__nullable)exception {
    
    [[DHOutOfMemoryManager sharedInstance] appDidCrash];
    return @"";
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"程序被杀死，applicationWillTerminate");
}

- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
