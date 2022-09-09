//
//  DHBlockCallbackViewController.h
//  BlockKnowledge
//
//  Created by jabraknight on 2022/4/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^receiveNoti)(NSString *showText);
typedef void (^MyReturnTextBlock)(NSString *showText);

@interface DHBlockCallbackViewController : UIViewController

@property (nonatomic, copy) NSString *nameP;

@property (nonatomic, copy) receiveNoti reception;

@property (nonatomic, copy) MyReturnTextBlock myReturnTextBlock;

@property (nonatomic,copy) void(^CallBack)(NSString *str);

@property(nonatomic,strong) NSDictionary *communicationMessage;
//类方法 必须使用类调用，在方法里面不能调用属性，存储在元类结构体里面的methodLists里面
+ (void)numberInfor:(void(^)(NSString * infor))inforBlock;

+ (BOOL)isWhiteSkinColor;

+ (BOOL)isWXAppInstalled;

+ (void)loadDetailCallBack:(NSString *)name callBack:(void(^)(NSString* str))FinishCallBack;
//实例方法 必须使用实例对象调用，可以在实例方法里面使用属性，实例方法也必须调用实例方法。存储在类结构体里面的methodLists里面
- (NSString *)textFunction:(NSString *)str __attribute__((warn_unused_result));;

- (void)textValueFunction:(void(^)(NSString * infor))inforBlock;

@end

NS_ASSUME_NONNULL_END
