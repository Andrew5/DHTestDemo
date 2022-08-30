//
//  DHSharedObject.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/8/24.
//

#import "DHSharedObject.h"

@implementation ALDInterceptor

- (id)forwardingTargetForSelector:(SEL)aSelector {
   if ([self.middleMan respondsToSelector:aSelector]) return self.middleMan;
   if ([self.receiver respondsToSelector:aSelector]) return self.receiver;
   return [super forwardingTargetForSelector:aSelector];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
   if ([self.middleMan respondsToSelector:aSelector]) return YES;
   if ([self.receiver respondsToSelector:aSelector]) return YES;
   return [super respondsToSelector:aSelector];
}

@end

@implementation DHSharedObject
{
//    NSHashTable *_hashTable;
//    采用NSMapTable我们刚好可以把两个参数分别作为key-value存储起来
    NSMapTable *_mapTable;
}

+ (instancetype)shared {
    static DHSharedObject *object = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        object = [[self alloc] init];
    });
    return object;
};

- (instancetype)init {
    if (self = [super init]) {
//        _hashTable = [NSHashTable weakObjectsHashTable];
        _mapTable = [NSMapTable weakToStrongObjectsMapTable];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self testDelegateAction];
//        });
    }
    return self;;
}

//- (void)addDelegate:(id)delegate {
//    if (delegate) {
//        [_hashTable addObject:delegate];
//    }
//}

- (void)addDelegate:(id)delegate dispathQueue:(dispatch_queue_t)queue_t {
    if (delegate) {
        //这里需要在delegate上包一层作为key，因为key需要能够实现NSCoping协议,同NSDictiony类似。
        NSMutableOrderedSet *orderSet = [NSMutableOrderedSet orderedSet];
        [orderSet addObject:delegate];
        [_mapTable setObject:queue_t?queue_t:dispatch_get_main_queue() forKey:orderSet.copy];
    }
}
- (void)testDelegateAction {

    [self.delegates enumerateObjectsUsingBlock:^(id<SharedObjectDelegate>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"");
        if ([obj respondsToSelector:@selector(func)]) {
            [obj func];
        }
    }];
}

- (NSArray *)delegates {
//     return _hashTable.allObjects;
    return _mapTable.dictionaryRepresentation.allKeys;
}
@end
