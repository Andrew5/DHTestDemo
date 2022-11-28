//
//  JKCicularProgressBar.m
//  Wopet
//
//  Created by mac on 2022/5/16.
//

#import "JKCicularProgressBar.h"
#import "Masonry.h"

#define kUIImageWithName(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

@interface JKCicularProgressBar ()

@property (nonatomic, strong)NSTimer * timer;

@property (nonatomic, strong)UIView *connectingView;
@property (nonatomic, strong)UIView *completeView;

///已经调用成功，在过渡动画中，如果外部调用失败，不用处理
@property (nonatomic, assign)BOOL successed;
@end

@implementation JKCicularProgressBar

- (instancetype)init {
    if (self = [super init]) {
        [self myInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self myInit];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self myInit];
}

- (void)myInit {
    self.backgroundColor = UIColor.clearColor;
    self.progerssBackgroundColor=[UIColor lightGrayColor];
    self.progerssColor= UIColor.redColor;
    
    self.connectingView = [UIView new];
    self.connectingView.backgroundColor = UIColor.clearColor;
    [self addSubview:self.connectingView];
    [self.connectingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(0);
    }];
    
    UIImageView *conImgView = [UIImageView new];
//    [conImgView setImage:[UIImage imageNamed:@""]];
//    UIImage *image = [UIImage imageNamed:@""];
//    conImgView.image = image;

    conImgView.image = kUIImageWithName(@"progress_donging_3");
    [self.connectingView addSubview:conImgView];
    [conImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(6);
    }];
    
    UIImageView *signalImgView = [UIImageView new];
    signalImgView.image = kUIImageWithName(@"progress_donging_2");
    [self.connectingView addSubview:signalImgView];
    [signalImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(conImgView.mas_top).offset(-5);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(12);
    }];
    
    UIImageView *devIcon = [UIImageView new];
    [self.connectingView addSubview:devIcon];
    [devIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.centerY.mas_equalTo(0);
        make.width.height.mas_equalTo(25);
    }];
    
    UIImageView *iphoneIcon = [UIImageView new];
    iphoneIcon.image = kUIImageWithName(@"progress_donging_4");
    [self.connectingView addSubview:iphoneIcon];
    [iphoneIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.centerY.mas_equalTo(0);
        make.width.height.mas_equalTo(25);
    }];
    
    self.progressLabel = [UILabel new];
    self.progressLabel.textAlignment = NSTextAlignmentCenter;
    self.progressLabel.textColor = UIColor.redColor;
    [self.connectingView addSubview:self.progressLabel];
    [self.progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
#if Iseefeeder
        make.top.bottom.mas_equalTo(0);
#else
        make.top.mas_equalTo(conImgView.mas_bottom).offset(5);
#endif
        make.left.right.mas_equalTo(0);
    }];

    self.completeView = [UIView new];
    self.completeView.backgroundColor = UIColor.clearColor;
    self.completeView.hidden = YES;
    [self addSubview:self.completeView];
    [self.completeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(0);
    }];
    
    self.statusImageView = [UIImageView new];
    self.statusImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.completeView addSubview:self.statusImageView];
    [self.statusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
#if Iseefeeder
        make.centerX.centerY.mas_equalTo(0);
        make.width.height.mas_equalTo(80);
#else
        make.top.bottom.left.right.mas_equalTo(0);
#endif
    }];
    
    self.progerWidth = 3;
    self.progress = 0.0;
    self.time = 100;
    self.interval = 0.1;
    self.transitionTime = 3.0;
#if Iseefeeder
    
#else
    devIcon.image = kUIImageWithName(@"ic_wopet_dev_thumb_fv01_v36");
//    NSString *addDeviceType = [KUserDefaults valueForKey:Add_Device_Type];
//    if ([addDeviceType isEqualToString:UNIT_TYPE_FX806]) {
//        devIcon.image = kUIImageWithName(@"WO_fw04");
//    } else if ([addDeviceType isEqualToString:UNIT_TYPE_FW04PlUS]) {
//        devIcon.image = kUIImageWithName(@"FW04-800");
//    } else if ([addDeviceType isEqualToString:UNIT_TYPE_FW08]) {
//        devIcon.image = kUIImageWithName(@"WO_fw08_big");
//    } else if ([addDeviceType isEqualToString:UNIT_TYPE_FW30]) {
//        devIcon.image = kUIImageWithName(@"WO_fw30_big");
//    } else if ([addDeviceType isEqualToString:UNIT_TYPE_LS1]||
//               [addDeviceType isEqualToString:UNIT_TYPE_FV01_PLUS]) {
//        devIcon.image = kUIImageWithName(@"ic_wopet_dev_thumb_fv01_v36");
//    } else if ([addDeviceType isEqualToString:UNIT_TYPE_LS2]) {
//        devIcon.image = kUIImageWithName(@"progress_donging_1");
//    } else if ([addDeviceType isEqualToString:UNIT_TYPE_LS3]) {
//        devIcon.image = kUIImageWithName(@"ic_wizard_m66_fv03");
//    } else if ([addDeviceType isEqualToString:UNIT_TYPE_LS5]||
//               [addDeviceType isEqualToString:UNIT_TYPE_LS5_PLUS]||
//               [addDeviceType isEqualToString:UNIT_TYPE_LS5_PLUS_PTZ]) {
//        devIcon.image = kUIImageWithName(@"ic_wizard_D01");
//    } else if ([addDeviceType isEqualToString:UNIT_TYPE_FV08]) {
//        devIcon.image = kUIImageWithName(@"fv08_配网");
//    } else {
//        devIcon.image = kUIImageWithName(@"progress_donging_1");
//    }
#endif
}

#pragma mark ===============开始===============
- (void)start{
    self.successed = NO;
    self.progress = 0.0;
    self.completeView.hidden = YES;
    self.connectingView.hidden = NO;
    self.progressLabel.text = [NSString stringWithFormat:@"%.0f%@",self.progress*100,@"%"];
    if(!self.timer){
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.interval target:self selector:@selector(timerClick) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    }
}
#pragma mark ===============定时器任务===============
- (void)timerClick{
    dispatch_queue_t queuestop = dispatch_queue_create("config_stop_find", NULL);
    dispatch_async(queuestop, ^{
    
        dispatch_async(dispatch_get_main_queue(), ^{
            self.progress += self.interval/self.time;
            self.progressLabel.text = [NSString stringWithFormat:@"%.0f%@",self.progress*100,@"%"];
            [self setNeedsDisplay];
            if (self.progress >= 1.0) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(cicularProgressBartTimeOut)]) {
                    [self.delegate cicularProgressBartTimeOut];
                }
                [self stop];
                return;
            }
        });
    });
}
#pragma mark ===============停止===============
- (void)stop{
    self.progress = 1.0;
    self.completeView.hidden = NO;
    self.connectingView.hidden = YES;
    [self.timer invalidate];
    self.timer = nil;
    [self setNeedsDisplay];
}
#pragma mark ===============成功，过渡动画===============
- (void)successful{
    self.successed = YES;
    [self.timer invalidate];
    self.timer = nil;
    if(!self.timer){
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.interval target:self selector:@selector(successfulTimerClick) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    }
    [self setNeedsDisplay];
}
- (void)successfulTimerClick{
    self.progress += self.interval/self.transitionTime;
    self.progressLabel.text = [NSString stringWithFormat:@"%.0f%@",self.progress*100,@"%"];
    [self setNeedsDisplay];
    if (self.progress >= 1.0) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(cicularProgressBarSuccessful)]) {
            [self.delegate cicularProgressBarSuccessful];
        }
        self.statusImageView.image = kUIImageWithName(@"progress_success");
        [self stop];
        return;
    }
}
#pragma mark ===============失败，过渡动画===============
- (void)failure{
    if (self.successed) {
        return;
    }
    [self.timer invalidate];
    self.timer = nil;
    if(!self.timer){
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.interval target:self selector:@selector(failureTimerClick) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    }
    [self setNeedsDisplay];
}
- (void)failureTimerClick{
    self.progress += self.interval/self.transitionTime;
    self.progressLabel.text = [NSString stringWithFormat:@"%.0f%@",self.progress*100,@"%"];
    [self setNeedsDisplay];
    if (self.progress >= 1.0) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(cicularProgressBarFailure)]) {
            [self.delegate cicularProgressBarFailure];
        }
        [self stop];
        return;
    }
}
- (void)drawRect:(CGRect)rect{
    UIBezierPath *backgroundPath = [[UIBezierPath alloc] init];
    backgroundPath.lineWidth = self.progerWidth;
    [self.progerssBackgroundColor set];
    backgroundPath.lineCapStyle = kCGLineCapRound;
    backgroundPath.lineJoinStyle = kCGLineJoinRound;
    CGFloat radius = (MIN(rect.size.width, rect.size.height) - self.progerWidth) * 0.5;
    [backgroundPath addArcWithCenter:(CGPoint){rect.size.width * 0.5, rect.size.height * 0.5} radius:radius startAngle:-M_PI * 0.5 endAngle:-M_PI * 0.5 + M_PI * 2  clockwise:YES];
    [backgroundPath stroke];
    UIBezierPath *progressPath = [[UIBezierPath alloc] init];
    progressPath.lineWidth = self.progerWidth;
    [self.progerssColor set];
    progressPath.lineCapStyle = kCGLineCapRound;
    progressPath.lineJoinStyle = kCGLineJoinRound;
    [progressPath addArcWithCenter:(CGPoint){rect.size.width * 0.5, rect.size.height * 0.5} radius:radius startAngle:-M_PI * 0.5 endAngle:-M_PI * 0.5 + M_PI * 2 * _progress clockwise:YES];
    [progressPath stroke];
}


@end
