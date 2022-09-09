//
//  DHBZLine.m
//  Appc
//
//  Created by jabraknight on 2021/3/1.
//

#import "DHBZLine.h"

@implementation DHBZLine


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    [super drawRect:rect];
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    //设置虚线颜色
    CGContextSetStrokeColorWithColor(currentContext, [UIColor redColor].CGColor);
    CGContextSetFillColorWithColor(currentContext, [UIColor clearColor].CGColor);//填充色设置成
    //设置虚线宽度
    CGContextSetLineWidth(currentContext, 2);
    //设置虚线绘制起点
    CGContextMoveToPoint(currentContext, 10, 10);
    //设置虚线绘制终点
    CGContextAddLineToPoint(currentContext, 10, self.frame.size.height);
    //设置虚线排列的宽度间隔:下面的arr中的数字表示先绘制3个点再绘制1个点
    int a = 10,b = 5,c = 5;
    CGFloat arr[] = {a,b};
//    arr改为｛10, 20, 10｝，则表示先绘制10个点，跳过20个点，绘制10个点，跳过10个点，再绘制20个点，如此反复
    //下面最后一个参数“2”代表排列的个数。
    //首先绘制【a减去c】，再跳过b，绘制a，反复绘制。
    CGContextSetLineDash(currentContext, c, arr, 2);
    CGContextDrawPath(currentContext, kCGPathStroke);
}

@end
