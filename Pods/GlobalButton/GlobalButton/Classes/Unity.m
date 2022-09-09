
//
//  Unity.m
//  testSingature
//
//  Created by jabraknight on 2021/7/26.
//  Copyright © 2021 zk. All rights reserved.
//

#import "Unity.h"

@implementation Unity

+ (instancetype)sharedInstance
{
    static Unity *__sharedInstance = nil;
    static dispatch_once_t dispatchToken;
    dispatch_once(&dispatchToken, ^{
        __sharedInstance = [[super allocWithZone:NULL] init];
    });
    return __sharedInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [self  sharedInstance];
}

- (id)copyWithZone:(nullable NSZone *)zone{
    return self;
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}
//获取当前最上层的控制器
+ (UIViewController *)getTopMostController {
    UIViewController *topVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    //循环之前tempVC和topVC是一样的
    UIViewController *tempVC = topVC;
    while (1) {
        if ([topVC isKindOfClass:[UITabBarController class]]) {
            topVC = ((UITabBarController*)topVC).selectedViewController;
        }
        if ([topVC isKindOfClass:[UINavigationController class]]) {
            topVC = ((UINavigationController*)topVC).visibleViewController;
        }
        if (topVC.presentedViewController) {
            topVC = topVC.presentedViewController;
        }
        //如果两者一样，说明循环结束了
        if ([tempVC isEqual:topVC]) {
            break;
        } else {
        //如果两者不一样，继续循环
            tempVC = topVC;
        }
    }
    return topVC;
}
- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        UINavigationController *nav = (UINavigationController *)rootVC;
        currentVC = [self getCurrentVCFrom:[nav topViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    
    return currentVC;
}

- (UIView *)topView
{
    UIViewController *vc = [self getCurrentVC];
    UIView *currentView = vc.view;
    return currentView;;
}

@end
