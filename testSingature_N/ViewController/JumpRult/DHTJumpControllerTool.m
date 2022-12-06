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
                unsigned int count;
                // 属性
                Ivar *ivarList = class_copyIvarList([[UIApplication sharedApplication] class], &count);
                // 成员变量
                objc_property_t *propertyList = class_copyPropertyList([windowScene.statusBarManager class] , &count);
                
                for (int i =0; i < count; i++) {
                    objc_property_t property = propertyList[i];
                    // 成员变量列表
                    NSString *nameStr = [NSString stringWithUTF8String:ivar_getName(ivarList[i])];
                    NSLog(@"***ivarName:%@", nameStr);
                    // 属性
                    const char *propertyName = property_getName(property);
                    NSLog(@"propertyName(%d) : %@", i, [NSString stringWithUTF8String:propertyName]);
                    //属性特性
                    const char *attributes = property_getAttributes(property);
                    NSString *attributesStr = [NSString stringWithCString:attributes encoding:NSUTF8StringEncoding];
                    NSLog(@"***attributes:%@", attributesStr);
                    
                    fprintf(stdout, "C语言 %s %s\n", property_getName(property), property_getAttributes(property));

                    // 获取属性所属类名
//                    unsigned int attrCount;
//                    NSString *propertyType;
//                    objc_property_attribute_t *attrs = property_copyAttributeList(property, &attrCount);
//                    NSString *attrs111 = [NSString stringWithCString:&attrs[i].name[0] encoding:NSUTF8StringEncoding];
//                    NSLog(@"%@",attrs111);
                    if ([nameStr isEqualToString:@"_statusBar"]) {
                        Ivar ivar = ivarList[i];
                        NSLog(@"%s", ivar_getTypeEncoding(ivar));
                        // 获得成员变量的类型
                        NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
                        // 如果属性是对象类型
                        NSRange range = [type rangeOfString:@"@"];
                        if (range.location != NSNotFound) {
                            type = [type substringWithRange:NSMakeRange(2, type.length - 3)];
                            // 排除系统的对象类型
                            if (![type hasPrefix:@"NS"]) {
                                // 将对象名转换为对象的类型，将新的对象字典转模型（递归）
                                Class class = NSClassFromString(type);
                                NSLog(@"%@",class);
                                id viewController = [[class alloc] init];
                                NSLog(@"statusBar：%@",  [viewController objectForKey:@"statusBar"]);
                                
                                unsigned int count11;
                                Ivar *ivarList1 = class_copyIvarList(class, &count11);
                                objc_property_t *propertyList = class_copyPropertyList(class , &count11);
                                for (int i =0; i < count11; i++) {
                                    objc_property_t property = propertyList[i];
                                    fprintf(stdout, "C语言 %s %s\n", property_getName(property), property_getAttributes(property));
                                    NSLog(@"成员变量列表**ivarName:%@", [NSString stringWithUTF8String:ivar_getName(ivarList1[i])]);
                                }
                            }
                        }
                    } else {
                        
                    }
                }
                free(ivarList);
                free(propertyList);
                UIStatusBarManager *statusBarManager = windowScene.statusBarManager;
                NSLog(@"状态栏包括安全区:%f",statusBarManager.statusBarFrame.size.height);//54
                NSLog(@"顶部安全区高度:%f",windowScene.windows.firstObject.safeAreaInsets.top);//59
                NSLog(@"底部安全区高度:%f",windowScene.windows.firstObject.safeAreaInsets.bottom);//34
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

- (void)setDict:(NSDictionary *)dict {
    Class c = self.class;
    while (c &&c != [NSObject class]) {
        unsigned int outCount = 0;
        Ivar *ivars = class_copyIvarList(c, &outCount);
        for (int i = 0; i < outCount; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            // 成员变量名转为属性名（去掉下划线 _ ）
            key = [key substringFromIndex:1];
            // 取出字典的值
            id value = dict[key];
            // 如果模型属性数量大于字典键值对数理，模型属性会被赋值为nil而报错
            if (value == nil) continue;
            // 获得成员变量的类型
            NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
            // 如果属性是对象类型
            NSRange range = [type rangeOfString:@"@"];
            if (range.location != NSNotFound) {
                // 那么截取对象的名字（比如@"Dog"，截取为Dog）
                type = [type substringWithRange:NSMakeRange(2, type.length - 3)];
                // 排除系统的对象类型
                if (![type hasPrefix:@"NS"]) {
                    // 将对象名转换为对象的类型，将新的对象字典转模型（递归）
                    Class class = NSClassFromString(type);
                    NSLog(@"%@",class);
                    //                    value = [class objectWithDict:value];
                }
                
            }
            // 将字典中的值设置到模型上[self setValue:value forKeyPath:key];
            
        }
        free(ivars);
        c = [c superclass];
    }
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
