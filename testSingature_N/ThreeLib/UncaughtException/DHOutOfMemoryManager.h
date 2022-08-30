//
//  DHOutOfMemoryManager.h
//  testSingature_N
//
//  Created by rilakkuma on 2022/8/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DHOutOfMemoryManager : NSObject

typedef void (^DHOutOfMemoryEventHandler)(BOOL wasInForeground);

+ (instancetype)sharedInstance;
- (void)beginMonitoringMemoryEventsWithHandler:(nonnull DHOutOfMemoryEventHandler)handler;
- (void)appDidCrash;

@end

NS_ASSUME_NONNULL_END
