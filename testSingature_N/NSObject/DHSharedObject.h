//
//  DHSharedObject.h
//  testSingature_N
//
//  Created by rilakkuma on 2022/8/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  SharedObjectDelegate <NSObject>
- (void)func;
@end
@interface ALDInterceptor : NSObject
 
@property (nonatomic, weak) id receiver;
@property (nonatomic, weak) id middleMan;
 
@end

@interface DHSharedObject : NSObject
@property (nonatomic,strong,readonly)NSArray *delegates;
+ (instancetype)shared;
//- (void)addDelegate:(id)delegate
/*
 @method
 @brief 注册一个监听对象到监听列表中
 @discussion 把监听对象添加到监听列表中准备接收相应的事件
 @param delegate 需要注册的监听对象
 @param queue 通知监听对象时的线程
 @result
*/
- (void)addDelegate:(id)delegate dispathQueue:(dispatch_queue_t)queue_t;

@end

NS_ASSUME_NONNULL_END
