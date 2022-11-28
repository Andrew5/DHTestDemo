//
//  LYDefineFoundation.h
//  LYInfoDemo
//
//  Created by boai on 2022/9/20.
//  Foundation 相关便捷方法

#ifndef LYDefineFoundation_h
#define LYDefineFoundation_h

#import <UserNotifications/UserNotifications.h>
#import <objc/message.h>
#import <objc/runtime.h>

#pragma mark - System

/// 系统版本
CG_INLINE CGFloat LYSystemVersion() {
    return UIDevice.currentDevice.systemVersion.floatValue;
}

/// app 版本
CG_INLINE NSString * _Nullable LYAppVersion() {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

/// app 版本H5专用：将版本号的.替换成_
CG_INLINE NSString * _Nullable LYAppVersionH5() {
    return [LYAppVersion() stringByReplacingOccurrencesOfString:@"." withString:@"_"];
}

/// app 构建版本
CG_INLINE NSString * _Nullable LYAppBundleVersion() {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

/// app 名称
CG_INLINE NSString * _Nullable LYAppDisplayName() {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

/// 判断用户是否允许接收通知
CG_INLINE BOOL LYIsUserNotificationEnable() {
    BOOL isEnable = NO;
    // iOS版本 >=8.0 处理逻辑
    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
    isEnable = (UIUserNotificationTypeNone == setting.types) ? NO : YES;
    
    return isEnable;
}


#pragma mark - Common Function

/// 对象是否为空
CG_INLINE BOOL LYIsEmpty(NSObject * _Nullable obj) {
    return ((!obj || [obj.class isSubclassOfClass:[NSNull class]]) ||
            ([obj respondsToSelector:@selector(length)] && [(NSData *)obj length] == 0) ||
            ([obj respondsToSelector:@selector(count)] && [(NSArray *)obj count] == 0));
}

/// 生成一个随机数
CG_INLINE NSInteger LYRandomNumber(NSInteger fromNum, NSInteger toNum) {
    return (NSInteger)(fromNum + (arc4random() % (toNum - fromNum + 1)));
}

#pragma mark - String
/// 判断字符串是否包含数字和字母
CG_INLINE BOOL LYIsStringContainNumberAndLetter(NSString * _Nullable stirng) {
    BOOL isContainNum = NO;
    BOOL isContainLetter = NO;
    
    NSRegularExpression *letterRegular = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger letterCount = [letterRegular numberOfMatchesInString:stirng options:NSMatchingReportProgress range:NSMakeRange(0, stirng.length)];
    //count是str中包含[A-Za-z]数字的个数，只要count>0，说明str中包含数字
    if (letterCount > 0) {
        isContainLetter = YES;
    }
    
    NSRegularExpression *numberRegular = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger numCount = [numberRegular numberOfMatchesInString:stirng options:NSMatchingReportProgress range:NSMakeRange(0, stirng.length)];
    //count是str中包含[0-9]数字的个数，只要count>0，说明str中包含数字
    if (numCount > 0) {
        isContainNum = YES;
    }
    
    BOOL isContainNumAndLetter = isContainNum || isContainLetter;
    return isContainNumAndLetter;
}

#pragma mark - runtime

/*! runtime set */
#define LYRuntimeSetObj(key, value) objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC)

/*! runtime setCopy */
#define LYRuntimeSetObjCOPY(key, value) objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY)

/*! runtime get */
#define LYRuntimeGetObj objc_getAssociatedObject(self, _cmd)

//CG_INLINE void LYRuntimeSetObj(id _Nonnull object, const void * _Nonnull key,
//                               id _Nullable value) {
//    objc_setAssociatedObject(object, key, value, OBJC_ASSOCIATION_RETAIN);
//}
//
//CG_INLINE void LYRuntimeSetObjCOPY(id _Nonnull object, const void * _Nonnull key,
//                               id _Nullable value) {
//    objc_setAssociatedObject(object, key, value, OBJC_ASSOCIATION_COPY);
//}
//
//CG_INLINE void LYRuntimeGetObj(id _Nonnull object, const void * _Nonnull key) {
//    objc_getAssociatedObject(object, key);
//}

#pragma mark - Hook

/// 交换对象方法
CG_INLINE BOOL LYHooKExchangeInstanceMethod(Class cls, SEL originalSEL, SEL swizzledSEL) {
    Method originalMethod = class_getInstanceMethod(cls, originalSEL);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSEL);
    
    if (!originalMethod || !swizzledMethod) {
        NSLog(@"找不到 originalMethod/swizzledMethod");
        return NO;
    }
    
    BOOL didAddMethod = class_addMethod(cls, originalSEL, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        //当前类不存在originalSelector而父类存在的时候didAddMethod为YES，避免影响父类的相关方法功能走replaceMethod
        class_replaceMethod(cls, swizzledSEL, method_getImplementation(originalMethod),method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    return YES;
}

/// 交换类方法
static inline BOOL LYHooKExchangeClassMethod(Class cls, SEL originalSEL, SEL swizzledSEL) {
    Method originalMethod = class_getClassMethod(cls, originalSEL);
    Method swizzledMethod = class_getClassMethod(cls, swizzledSEL);
    
    if (!originalMethod || !swizzledMethod) {
        NSLog(@"找不到 originalMethod/swizzledMethod");
        return NO;
    }
    
    BOOL didAddMethod = class_addMethod(object_getClass(cls), originalSEL, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        //当前类不存在originalSelector而父类存在的时候didAddMethod为YES，避免影响父类的相关方法功能走replaceMethod
        class_replaceMethod(cls, swizzledSEL, method_getImplementation(originalMethod),method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    return YES;
}

/// 交换类方法
static inline BOOL LYHooKExchangeClassMethod_C(Class cls, SEL originalSEL, SEL swizzledSEL) {
    Method originalMethod = class_getClassMethod(cls, originalSEL);
    Method swizzledMethod = class_getClassMethod(cls, swizzledSEL);
    
    if (!originalMethod || !swizzledMethod) {
        NSLog(@"找不到 originalMethod/swizzledMethod");
        return NO;
    }
    
    BOOL didAddMethod = class_addMethod(object_getClass(cls), originalSEL, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        //当前类不存在originalSelector而父类存在的时候didAddMethod为YES，避免影响父类的相关方法功能走replaceMethod
        class_replaceMethod(cls, swizzledSEL, method_getImplementation(originalMethod),method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    return YES;
}

#pragma mark - Other




#endif /* LYDefineFoundation_h */
