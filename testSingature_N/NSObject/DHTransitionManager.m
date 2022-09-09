//
//  DHTransitionManager.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/9/9.
//

#import "DHTransitionManager.h"

typedef enum : NSUInteger {
    Fade = 4,                   //淡入淡出
    Push,                       //推挤
    Reveal,                     //揭开
    MoveIn,                     //覆盖
    Cube,                       //立方体
    SuckEffect,                 //吮吸
    OglFlip,                    //翻转
    RippleEffect,               //波纹
    PageCurl,                   //翻页
    PageUnCurl,                 //反翻页
    CameraIrisHollowOpen,       //开镜头
    CameraIrisHollowClose,      //关镜头
    CurlDown,                   //下翻页
    CurlUp,                     //上翻页
    FlipFromLeft,               //左翻转
    FlipFromRight,              //右翻转
    
} AnimationType;

@interface DHTransitionManager ()
@property (nonatomic, assign) int subtype;
@end

@implementation DHTransitionManager

///TODO: 自定义转场动画
- (void)transitionView:(UIView *)toView forme:(int)type {
    
    AnimationType animationType = 0;
    
    NSString *subtypeString;
    _subtype = type;
    switch (_subtype) {
        case 0:
            subtypeString = kCATransitionFromLeft;
            break;
        case 1:
            subtypeString = kCATransitionFromBottom;
            break;
        case 2:
            subtypeString = kCATransitionFromRight;
            break;
        case 3:
            subtypeString = kCATransitionFromTop;
            break;
        default:
            break;
    }
//    _subtype += 1;
//    if (_subtype > 3) {
//        _subtype = 0;
//    }
    if (type >= 4) {
        animationType = type;
    }

    switch (animationType) {
        case Fade:
            [self transitionWithType:kCATransitionFade WithSubtype:subtypeString ForView:toView];
            break;
        
        case Push:
            [self transitionWithType:kCATransitionPush WithSubtype:subtypeString ForView:toView];
            break;
            
        case Reveal:
            [self transitionWithType:kCATransitionReveal WithSubtype:subtypeString ForView:toView];
            break;
            
        case MoveIn:
            [self transitionWithType:kCATransitionMoveIn WithSubtype:subtypeString ForView:toView];
            break;
            
        case Cube:
            [self transitionWithType:@"cube" WithSubtype:subtypeString ForView:toView];
            break;
        
        case SuckEffect:
            [self transitionWithType:@"suckEffect" WithSubtype:subtypeString ForView:toView];
            break;
            
        case OglFlip:
            [self transitionWithType:@"oglFlip" WithSubtype:subtypeString ForView:toView];
            break;
            
        case RippleEffect:
            [self transitionWithType:@"rippleEffect" WithSubtype:subtypeString ForView:toView];
            break;
            
        case PageCurl:
            [self transitionWithType:@"pageCurl" WithSubtype:subtypeString ForView:toView];
            break;
            
        case PageUnCurl:
            [self transitionWithType:@"pageUnCurl" WithSubtype:subtypeString ForView:toView];
            break;
            
        case CameraIrisHollowOpen:
            [self transitionWithType:@"cameraIrisHollowOpen" WithSubtype:subtypeString ForView:toView];
            break;
            
        case CameraIrisHollowClose:
            [self transitionWithType:@"cameraIrisHollowClose" WithSubtype:subtypeString ForView:toView];
            break;
        
        case CurlDown:
            [self animationWithView:toView WithAnimationTransition:UIViewAnimationTransitionCurlDown];
            break;
        
        case CurlUp:
            [self animationWithView:toView WithAnimationTransition:UIViewAnimationTransitionCurlUp];
            break;
            
        case FlipFromLeft:
            [self animationWithView:toView WithAnimationTransition:UIViewAnimationTransitionFlipFromLeft];
            break;
            
        case FlipFromRight:
            [self animationWithView:toView WithAnimationTransition:UIViewAnimationTransitionFlipFromRight];
            break;

        default:
            break;
    }
    
//    static int i = 0;
//    if (i == 0) {
//        [self addBgImageWithImageName:IMAGE1];
//        i = 1;
//    }
//    else
//    {
//        [self addBgImageWithImageName:IMAGE2];
//        i = 0;
//    }
}

- (void)animationWithView:(UIView *)view WithAnimationTransition:(UIViewAnimationTransition)transition {
    [UIView animateWithDuration:0.7 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:view cache:YES];
    }];
}

- (void)transitionWithType:(NSString *)type WithSubtype:(NSString *)subtype ForView:(UIView *)view {
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = 0.7;
    
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        
        //设置子类
        animation.subtype = subtype;
    }
    //设置运动速度
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [view.layer addAnimation:animation forKey:@"animation"];
}

@end
