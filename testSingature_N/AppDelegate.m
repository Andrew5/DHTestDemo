//
//  AppDelegate.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/8/20.
//

#import "AppDelegate.h"
#import "QDExceptionHandler.h"
#import "DHOutOfMemoryManager.h"
#import "GlobalButton/DHGlobalConfig.h"
#import "GlobalButtonSwift-umbrella.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.window.backgroundColor = [UIColor whiteColor];
//    [self.window makeKeyAndVisible];
    //获取异常
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
    InstallSignalHandler();//信号量截断
    InstallUncaughtExceptionHandler();
    [[DHOutOfMemoryManager sharedInstance] beginMonitoringMemoryEventsWithHandler:^(BOOL wasInForeground) {
        if (wasInForeground) {
            NSLog(@"----report----");
        }
    }];
    
    // 全剧按钮
    [DHGlobalConfig setEnvironmentMap:@{
        @"UAT":@"www.UAT.com",
        @"PRO":@"www.PRO.com",
        @"SIT":@"www.SIT.com",
    } currentEnv:DHGlobalConfig.envstring];

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
    
    /*
     // AppDelegate 并不遵循单一功能原则，它要负责处理很多事情，如应用生命周期回调、远程推送、本地推送、应用跳转(HandleOpenURL)；如果集成了第三方服务，大多数还需要在应用启动时初始化，并且需要处理应用跳转，如果在 AppDelegate 中做这些事情，势必让它变得很庞大。
     这个面向服务，应该达成下面这两个要求：
     添加或者删除一个服务的时候，不需要更改 AppDelegate 中的任何一行代码。
     AppDelegate 不实现 UIApplicationDelegate 协议中的方法，由协议去实现
     第一点是要求实现可插拔特性。关于第二点，可能比较粗暴简单的做法是在 AppDelegate 里面实现所有的 UIApplicationDelegate 代理方法，然后在方法中把消息转发给消息。
     通常情况下，你需要在 AppDelegate 中实现每一个需要用到的代理方法，在这些代理方法中，调用很多不同的服务。但是上面第二点对我们提出要求：只能由各个服务去实现它需要的代理方法。这里我利用了 Objective-C 的消息转发机制，把 AppDelegate 不能处理的消息转发给各个服务。
    if ([super respondsToSelector:@selector(application:didFinishLaunchingWithOptions:)]) {
        [super application:application didFinishLaunchingWithOptions:launchOptions];
    }
     */
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


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options API_AVAILABLE(ios(13.0)) {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"程序被杀死，applicationWillTerminate");
}

- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions  API_AVAILABLE(ios(13.0)){
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
