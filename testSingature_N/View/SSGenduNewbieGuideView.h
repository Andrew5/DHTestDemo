//
//  SSGenduNewbieGuideVIew.h
//  SSGendu
//
//  Created by lxkboy on 2021/10/20.
//新手引导

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, PESSGenduGuideType) {
    PESSGenduGuideTypeOfList = 0,       // 列表页新手指引
    PESSGenduGuideTypeOfStarRecording   //跟读单词新手指引
};
@interface SSGenduNewbieGuideView : UIView


/// 暂时引导view
/// @param guideType 引导页面类型
/// @param frame 镂空位置
+ (instancetype)showGuideViewWithHollowOutPosition:(CGRect)frame guideType:(PESSGenduGuideType)type clickView:(id)clickView complete:(void(^)(void))completeBlock;
@end

NS_ASSUME_NONNULL_END
typedef NS_ENUM (NSInteger, PEPointReaderType) {
    PEPointReaderTypeOfClickContent = 0,//点击热点区域
    PEPointReaderTypeOfOpenSet = 1,//打开设置
    PEPointReaderTypeOfSetPlaySpeed = 2,//设置速度
    PEPointReaderTypeOfChoiceClassModel = 3,//选择本课复读模式
    PEPointReaderTypeOfPlayClass = 4,//点击播放课文
    PEPointReaderTypeOfNextTask = 5, //下一个任务
};
