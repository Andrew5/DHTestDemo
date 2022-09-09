//
//  DHTestMessage.h
//  testSingature_N
//
//  Created by rilakkuma on 2022/8/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
static NSString * const SD_PLT              = @"iPhone";
extern NSString * const ABC;

@interface testDog : NSObject
@property (nonatomic, copy) NSString *name;

- (void)saygoodbay;
@end

@interface DHTestMessage : NSObject
//文字内容的实际高度
@property (nonatomic, assign) float titleActualH;

//文字内容的最大高度，具体的数值是 一行文本的高度*期望的最大显示行数
@property (nonatomic, assign) float titleMaxH;

//内容是否展开（默认不设置，都是NO，收起状态）
@property (nonatomic, assign) BOOL isOpen;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *fragment;
@property (nonatomic, copy) NSString *host;
@property (nonatomic, copy) NSString *pathname;
@property (nonatomic, strong) NSMutableArray *students;
- (void)saySomething;
+ (DHTestMessage *)sharedInstance;
@end

NS_ASSUME_NONNULL_END
