//
//  SSGenduNewbieGuideVIew.m
//  SSGendu
//
//  Created by lxkboy on 2021/10/20.
//

#import "SSGenduNewbieGuideView.h"
//#import <TBXLib/TBXLibHeader.h>
#import <Masonry/Masonry.h>

@interface SSGenduNewbieGuideView ()
@property (nonatomic, strong) id clickView;//手势触发view
@property (nonatomic, strong) UIImageView *spanImgView;//手势图片
@property (nonatomic, strong) UIView *messageBgView;//白底
@property (nonatomic, strong) UILabel *messageLab;//提示信息
@property (nonatomic, strong) UIBezierPath *path;//路径
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, assign) CGRect hollowOutFrame;
@property (nonatomic, assign) PESSGenduGuideType guideType;//引导类型
@property (nonatomic, copy) void(^completeBlock)(void);
@end

@implementation SSGenduNewbieGuideView

/// 暂时引导view
/// @param guideType 引导页面类型
/// @param frame 镂空位置
+ (instancetype)showGuideViewWithHollowOutPosition:(CGRect)frame guideType:(PESSGenduGuideType)type clickView:(id)clickView complete:(void(^)(void))completeBlock{
    SSGenduNewbieGuideView *guideView = [[SSGenduNewbieGuideView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    guideView.hollowOutFrame = frame;
    guideView.completeBlock = completeBlock;
    guideView.clickView = clickView;
    guideView.guideType = type;
    [guideView initUI];
    [[UIApplication sharedApplication].keyWindow addSubview:guideView];
    return guideView;
}

//UI创建
- (void)initUI {
    self.backgroundColor = UIColor.clearColor;
    //添加文字提示
    [self addSubview:self.messageBgView];
    [self.messageBgView addSubview:self.messageLab];
        //列表页面的引导
        //添加镂空
    [self drawBorderMaskLayer];
    [self addSubview:self.spanImgView];
    if(self.guideType == PESSGenduGuideTypeOfList) {
        self.spanImgView.image = [UIImage imageNamed:@"IMG_0087"];
        self.messageLab.text = @"点击这里，可以练习和测评单词的发音啦";
    } else {
        self.spanImgView.image = [UIImage imageNamed:@"IMG_0087"];
        self.messageLab.text = @"点击这里，开始录音";
        self.messageLab.textAlignment = NSTextAlignmentCenter;
        self.messageLab.adjustsFontSizeToFitWidth = YES;
        self.messageLab.minimumScaleFactor = 0.8;
    }


    [self layoutUI];
}

//绘制镂空
- (void)drawBorderMaskLayer {
    //绘制镂空
    //整体的绘制区域
    self.path = [UIBezierPath bezierPathWithRect:self.bounds];
    [self.path setUsesEvenOddFillRule:YES];
    //镂空区域,根据需求这里需要改为圆
    CGRect changeFrame;
    if(self.guideType == PESSGenduGuideTypeOfList) {
    changeFrame = CGRectMake(CGRectGetMinX(self.hollowOutFrame), CGRectGetMinY(self.hollowOutFrame), CGRectGetWidth(self.hollowOutFrame), CGRectGetWidth(self.hollowOutFrame));
    } else {
        changeFrame = CGRectMake(CGRectGetMinX(self.hollowOutFrame) - (CGRectGetHeight(self.hollowOutFrame) - CGRectGetWidth(self.hollowOutFrame))/2.0, CGRectGetMinY(self.hollowOutFrame), CGRectGetHeight(self.hollowOutFrame), CGRectGetHeight(self.hollowOutFrame));
    }

    CGFloat radius = changeFrame.size.width/2.0;
    UIBezierPath *clearPath = [[UIBezierPath bezierPathWithRoundedRect:changeFrame cornerRadius:radius] bezierPathByReversingPath];
    
    [self.path appendPath:clearPath];
    
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.fillColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5].CGColor;//wkAlphaColor(0, 0, 0, 0.5).CGColor;
    [self.shapeLayer setFillRule:kCAFillRuleEvenOdd];
    self.shapeLayer.path = self.path.CGPath;
    [self.layer insertSublayer:self.shapeLayer below:self.messageBgView.layer];
}

//约束
- (void)layoutUI {
    if(self.guideType == PESSGenduGuideTypeOfList) {
        //列表引导
        self.spanImgView.frame = CGRectMake(CGRectGetMaxX(self.hollowOutFrame) - 95, CGRectGetMaxY(self.hollowOutFrame) - 70, 68, 68);
        self.messageBgView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 200 - 40, CGRectGetMaxY(self.spanImgView.frame) - 8, 200, 65);
    } else {
        //跟读单词引导
        self.spanImgView.frame = CGRectMake(CGRectGetMidX(self.hollowOutFrame), CGRectGetMinY(self.hollowOutFrame) - 15, 68, 68);
        [self.messageBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.spanImgView).offset(-35);
            make.bottom.mas_equalTo(self.spanImgView.mas_top).offset(10);
            make.size.mas_equalTo(CGSizeMake(200, 45));
        }];
    }

        [self.messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.messageBgView).insets(UIEdgeInsetsMake(5,20,5,20));
        }];

}

//完成按钮点击
- (void)clickBtn {
    [self removeFromSuperview];
}

- (void)tapController {
    !self.completeBlock ?: self.completeBlock();
    [self removeFromSuperview];
}

#pragma mark === 拦截点击手势

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    //镂空区域
    UIBezierPath *hollowOutPath = [UIBezierPath bezierPathWithRoundedRect:self.hollowOutFrame cornerRadius:5];
    //判断点击事件是否在镂空区域
    if ([hollowOutPath containsPoint:point]) {
        [self clickBtn];
        return self.clickView;
    } else {
        return [super hitTest:point withEvent:event];
    }
}

#pragma mark lazy
- (UIView *)messageBgView {
    if (!_messageBgView) {
        _messageBgView = [[UIView alloc]init];
        _messageBgView.backgroundColor = UIColor.whiteColor;
        _messageBgView.layer.cornerRadius = 12;
    }
    return _messageBgView;
}

- (UILabel *)messageLab {
    if (!_messageLab) {
        _messageLab = [[UILabel alloc]init];
        _messageLab.font = [UIFont systemFontOfSize:15];
        _messageLab.textColor = UIColor.redColor;
        _messageLab.numberOfLines = 0;
        _messageLab.backgroundColor = UIColor.whiteColor;
        _messageLab.userInteractionEnabled = YES;
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapController)];
        [_messageLab addGestureRecognizer:tap];
    }
    return _messageLab;
}

- (UIImageView *)spanImgView {
    if (!_spanImgView) {
        _spanImgView = [[UIImageView alloc]init];
        _spanImgView.image = [UIImage imageNamed:@"IMG_0087"];
        _spanImgView.userInteractionEnabled = YES;
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapController)];
        [_spanImgView addGestureRecognizer:tap];
    }
    return _spanImgView;
}

@end
