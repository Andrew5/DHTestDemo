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
