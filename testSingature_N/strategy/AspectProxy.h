//
//  AspectProxy.h
//  testSingature_N
//
//  Created by rilakkuma on 2022/12/10.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>

NS_ASSUME_NONNULL_BEGIN
// 定义转发对象
@interface AspectProxy : NSObject

@property (nonatomic, weak) id receiver;

@end



NS_ASSUME_NONNULL_END
