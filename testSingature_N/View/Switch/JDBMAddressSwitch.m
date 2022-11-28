//
//  JDBMAddressSwitch.m
//  JDBMWorkbenchModule
//
//  Created by ext.wangdongdong3 on 2022/6/6.
//

#import "JDBMAddressSwitch.h"

@interface JDBMAddressSwitch ()

/// 滑块
@property (nonatomic, strong) UIImageView *thumbImageView;

@end

@implementation JDBMAddressSwitch

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.thumbImageView];
        self.offColor = UIColor.whiteColor;
        self.onColor = UIColor.redColor;
        self.isOn = NO;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self styleChange];
    self.layer.cornerRadius = CGRectGetHeight(self.frame) / 2;
    _thumbImageView.layer.cornerRadius = (CGRectGetHeight(self.frame) - 8) / 2;
}
    
- (void)endTrackingWithTouch:(nullable UITouch *)touch withEvent:(nullable UIEvent *)event {
    [super endTrackingWithTouch:touch withEvent:event];

    _isOn = !_isOn;
    [self styleChange];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

/// 切换样式
- (void)styleChange {
    CGRect rect;
    if (_isOn) {
        rect = CGRectMake(CGRectGetWidth(self.frame) - (CGRectGetHeight(self.frame) - 8) - 4, 4, CGRectGetHeight(self.frame) - 8, CGRectGetHeight(self.frame) - 8);
        self.backgroundColor = _onColor;
        _thumbImageView.image = _thumbOnImage;
    }
    else {
        rect = CGRectMake(4, 4, CGRectGetHeight(self.frame) - 8, CGRectGetHeight(self.frame) - 8);
        self.backgroundColor = _offColor;
        _thumbImageView.image = _thumbOffImage;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.thumbImageView.frame = rect;
    } completion:nil];
}
  
#pragma mark - setter, getter

- (UIImageView *)thumbImageView {
    if (!_thumbImageView) {
        _thumbImageView = [UIImageView new];
        _thumbImageView.backgroundColor = UIColor.whiteColor;
    }
    return _thumbImageView;
}
    
- (void)setIsOn:(BOOL)isOn {
    _isOn = isOn;
    [self styleChange];
}

- (void)setOffColor:(UIColor *)offColor {
    _offColor = offColor;
}

- (void)setOnColor:(UIColor *)onColor {
    _onColor = onColor;
}

- (void)setThumbOffImage:(UIImage *)thumbOffImage {
    _thumbOffImage = thumbOffImage;
}

- (void)setThumbOnImage:(UIImage *)thumbOnImage {
    _thumbOnImage = thumbOnImage;
}

@end
