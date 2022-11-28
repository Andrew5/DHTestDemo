//
//  CircleView.m
//  testSingature
//
//  Created by jabraknight on 2021/11/6.
//  Copyright © 2021 zk. All rights reserved.
//

#import "CircleView.h"

IB_DESIGNABLE //预览效果
IBInspectable //在右边切换到 Attributes inspector 栏目，就可以在顶部看到我们自定义的属性。
@interface CircleView ()
@property (nonatomic, assign) IBInspectable CGFloat lineWidth; // 圆形线条的宽度
@property (nonatomic, assign) IBInspectable CGFloat radius; // 圆形的半径
@property (nonatomic, strong) IBInspectable UIColor *color; // 绘制的颜色
@property (nonatomic, assign) IBInspectable BOOL fill; // 是否填充，是不是实心圆
@end
@implementation CircleView
- (void)drawRect:(CGRect)rect {

    // 计算中心点
    CGFloat centerX = (self.bounds.size.width - self.bounds.origin.x) / 2;
    CGFloat centerY = (self.bounds.size.height - self.bounds.origin.y) / 2;

    UIBezierPath *path = [[UIBezierPath alloc] init];
    // 添加一个圆形
    [path addArcWithCenter:CGPointMake(centerX, centerY) radius:_radius startAngle:0 endAngle:360 clockwise:YES];

    // 设置线条宽度
    path.lineWidth = _lineWidth;

    // 设置线条颜色
    [_color setStroke];

    // 绘制线条
    [path stroke];

    if (_fill) {
        // 如果是实心圆，设置填充颜色
        [_color setFill];
        // 填充圆形
        [path fill];
    }

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
