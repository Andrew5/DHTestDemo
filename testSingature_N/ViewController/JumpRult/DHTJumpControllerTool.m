//
//  DHTJumpControllerTool.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/12/4.
//

#import "DHTJumpControllerTool.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@implementation DHTJumpControllerTool

+ (void)pushViewControllerWithParams:(NSDictionary *)params {
    
    // 取出控制器类名
    NSString *classNameStr = [NSString stringWithFormat:@"%@", [params[@"class"] stringByAppendingString:@"ViewController"]];
    const char *className = [classNameStr cStringUsingEncoding:NSASCIIStringEncoding];
    
    // 根据字符串返回一个类
    Class classVC = objc_getClass(className);
    if (!classVC) {
        // 创建一个类
        Class superClass = [NSObject class];
        classVC = objc_allocateClassPair(superClass, className, 0);
        // 注册创建的这个类
        objc_registerClassPair(classVC);
    }
    // 创建对象（就是控制器对象）
    UIViewController *instance = [[classVC alloc] init];
    NSDictionary *propertys = params[@"property"];
    [propertys enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        // 检测这个对象是否存在该属性
        if ([DHTJumpControllerTool checkIsExistPropertyWithInstance:instance verifyPropertyName:key]) {
            // 利用 KVC 对控制器对象的属性赋值
            [instance setValue:obj forKey:key];
        }
    }];

    // 跳转到对应的控制器
    [[DHTJumpControllerTool topViewController].navigationController pushViewController:instance animated:YES];
}

// 检测对象是否存在该属性
+ (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName {
    
    unsigned int count, i;
    // 获取对象里的属性列表
    objc_property_t *properties = class_copyPropertyList([instance class], &count);
    
    for (i = 0; i < count; i++) {
        objc_property_t property =properties[i];
        // 属性名转成字符串
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        // 判断该属性是否存在
        if ([propertyName isEqualToString:verifyPropertyName]) {
            free(properties);
            return YES;
        }
    }
    free(properties);
    return NO;
}

// 获取当前显示在屏幕最顶层的 ViewController
+ (UIViewController *)topViewController {

    UIWindow * window = nil;
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) {
            if (@available(iOS 15.0, *)) {
                NSLog(@"%@",windowScene.keyWindow);
                UIStatusBarManager *statusBarManager = windowScene.statusBarManager;
                NSLog(@"状态栏包括安全区:%f",statusBarManager.statusBarFrame.size.height);
                NSLog(@"顶部安全区高度:%f",windowScene.windows.firstObject.safeAreaInsets.top);
                NSLog(@"底部安全区高度:%f",windowScene.windows.firstObject.safeAreaInsets.bottom);
            } else {
                NSLog(@"%@",windowScene.windows);
                // Fallback on earlier versions
            }
            if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                window = windowScene.windows.firstObject;
                break;
            }
        }
    } else {
        window = [UIApplication sharedApplication].keyWindow;
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        NSLog(@"top-%f",window.safeAreaInsets.top);
    }

    if (window == nil) {
        window = [DHTJumpControllerTool getRootWindow];
    } else {
        
    }
    UIViewController *resultVC = [DHTJumpControllerTool _topViewController:[window rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [DHTJumpControllerTool _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIWindow *)getRootWindow {

    NSArray *windows = [[UIApplication sharedApplication] windows];
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        if ([window isKindOfClass:[UIWindow class]] &&
            window.windowLevel == UIWindowLevelNormal &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds))
            return window;
    }
    return [UIApplication sharedApplication].keyWindow;
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [DHTJumpControllerTool _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [DHTJumpControllerTool _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}
@end
