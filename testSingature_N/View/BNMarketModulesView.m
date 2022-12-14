//
//  BNMarketModulesView.m
//  MyText
//
//  Created by 段雨田 on 2021/12/8.
//

#import "BNMarketModulesView.h"


#define ViewWidth self.bounds.size.width
#define ViewHeight self.bounds.size.height

//#import "NSDate+YTCalendar.h"
//
@interface BNMarketModulesView ()

//@property (weak, nonatomic) IBOutlet UILabel *reportNumLabel;


@end


@implementation BNMarketModulesView

- (void)reloadData {
  
//  _reportNumLabel.text = self.tools.workBenchModel.saas.reportNum;
//  _thisYearValueLabel.text = self.tools.workBenchModel.saas.thisYearValue;
//  _thisYearLabel.text = [NSString stringWithFormat:@"%zd年产值(万)",[[NSDate date] dateYear]];
  
}
// 覆盖drawRect方法，你可以在此自定义绘画和动画
- (void)drawRect:(CGRect)rect
{
    //An opaque type that represents a Quartz 2D drawing environment.
    //一个不透明类型的Quartz 2D绘画环境,相当于一个画布,你可以在上面任意绘画
    CGContextRef context = UIGraphicsGetCurrentContext();
      
      
    CGContextSetRGBFillColor (context,  1, 0, 0, 1.0);//设置填充颜色
    UIFont  *font = [UIFont boldSystemFontOfSize:15.0];//设置
    [@"画圆：" drawInRect:CGRectMake(10, 20, 80, 20) withAttributes:@{NSFontAttributeName:font}];
    [@"画线及孤线：" drawInRect:CGRectMake(10, 80, 100, 20) withAttributes:@{NSFontAttributeName:font}];
    [@"画矩形：" drawInRect:CGRectMake(10, 120, 80, 20) withAttributes:@{NSFontAttributeName:font}];
    [@"画扇形和椭圆：" drawInRect:CGRectMake(10, 160, 110, 20) withAttributes:@{NSFontAttributeName:font}];
    [@"画三角形：" drawInRect:CGRectMake(10, 220, 80, 20) withAttributes:@{NSFontAttributeName:font}];
    [@"画圆角矩形：" drawInRect:CGRectMake(10, 260, 100, 20) withAttributes:@{NSFontAttributeName:font}];
    [@"画贝塞尔曲线：" drawInRect:CGRectMake(10, 300, 100, 20) withAttributes:@{NSFontAttributeName:font}];
    [@"图片：" drawInRect:CGRectMake(10, 340, 80, 20) withAttributes:@{NSFontAttributeName:font}];
  
      
    //边框圆
    CGContextSetRGBStrokeColor(context,1,1,1,1.0);//画笔线的颜色
    CGContextSetLineWidth(context, 1.0);//线的宽度
    //void CGContextAddArc(CGContextRef c,CGFloat x, CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle, int clockwise)1弧度＝180°/π （≈57.3°） 度＝弧度×180°/π 360°＝360×π/180 ＝2π 弧度
    // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
    CGContextAddArc(context, 100, 20, 15, 0, 2*M_PI, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathStroke); //绘制路径
      
    //填充圆，无边框
    CGContextAddArc(context, 150, 30, 30, 0, 2*M_PI, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathFill);//绘制填充
      
    //画大圆并填充颜
    UIColor*aColor = [UIColor colorWithRed:1 green:0.0 blue:0 alpha:1];
    CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
    CGContextSetLineWidth(context, 3.0);//线的宽度
    CGContextAddArc(context, 250, 40, 40, 0, 2*M_PI, 0); //添加一个圆
    //kCGPathFill填充非零绕数规则,kCGPathEOFill表示用奇偶规则,kCGPathStroke路径,kCGPathFillStroke路径填充,kCGPathEOFillStroke表示描线，不是填充
    CGContextDrawPath(context, kCGPathFillStroke); //绘制路径加填充
      
      
    //画线
    CGPoint aPoints[2];//坐标点
    aPoints[0] =CGPointMake(100, 80);//坐标1
    aPoints[1] =CGPointMake(130, 80);//坐标2
    //CGContextAddLines(CGContextRef c, const CGPoint points[],size_t count)
    //points[]坐标数组，和count大小
    CGContextAddLines(context, aPoints, 2);//添加线
    CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
      
    //画笑脸弧线
    //左
    CGContextSetRGBStrokeColor(context, 0, 0, 1, 1);//改变画笔颜色
    CGContextMoveToPoint(context, 140, 80);//开始坐标p1
    //CGContextAddArcToPoint(CGContextRef c, CGFloat x1, CGFloat y1,CGFloat x2, CGFloat y2, CGFloat radius)
    //x1,y1跟p1形成一条线的坐标p2，x2,y2结束坐标跟p3形成一条线的p3,radius半径,注意, 需要算好半径的长度,
    CGContextAddArcToPoint(context, 148, 68, 156, 80, 10);
    CGContextStrokePath(context);//绘画路径
      
    //右
    CGContextMoveToPoint(context, 160, 80);//开始坐标p1
    //CGContextAddArcToPoint(CGContextRef c, CGFloat x1, CGFloat y1,CGFloat x2, CGFloat y2, CGFloat radius)
    //x1,y1跟p1形成一条线的坐标p2，x2,y2结束坐标跟p3形成一条线的p3,radius半径,注意, 需要算好半径的长度,
    CGContextAddArcToPoint(context, 168, 68, 176, 80, 10);
    CGContextStrokePath(context);//绘画路径
      
    //右
    CGContextMoveToPoint(context, 150, 90);//开始坐标p1
    //CGContextAddArcToPoint(CGContextRef c, CGFloat x1, CGFloat y1,CGFloat x2, CGFloat y2, CGFloat radius)
    //x1,y1跟p1形成一条线的坐标p2，x2,y2结束坐标跟p3形成一条线的p3,radius半径,注意, 需要算好半径的长度,
    CGContextAddArcToPoint(context, 158, 102, 166, 90, 10);
    CGContextStrokePath(context);//绘画路径
    //注，如果还是没弄明白怎么回事，请参考：http://donbe.blog.163.com/blog/static/138048021201052093633776/
      
      
    CGContextStrokeRect(context,CGRectMake(100, 120, 10, 10));//画方框
    CGContextFillRect(context,CGRectMake(120, 120, 10, 10));//填充框
    //矩形，并填弃颜色
    CGContextSetLineWidth(context, 2.0);//线的宽度
    aColor = [UIColor blueColor];//blue蓝色
    CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
    aColor = [UIColor yellowColor];
    CGContextSetStrokeColorWithColor(context, aColor.CGColor);//线框颜色
    CGContextAddRect(context,CGRectMake(140, 120, 60, 30));//画方框
    CGContextDrawPath(context, kCGPathFillStroke);//绘画路径
      
    //矩形，并填弃渐变颜色
    //关于颜色参考http://blog.sina.com.cn/s/blog_6ec3c9ce01015v3c.html
    //http://blog.csdn.net/reylen/article/details/8622932
    //第一种填充方式，第一种方式必须导入类库quartcore并#import ，这个就不属于在context上画，而是将层插入到view层上面。那么这里就设计到Quartz Core 图层编程了。
    CAGradientLayer *gradient1 = [CAGradientLayer layer];
    gradient1.frame = CGRectMake(240, 120, 60, 30);
    gradient1.colors = [NSArray arrayWithObjects:(id)[UIColor whiteColor].CGColor,
                        (id)[UIColor grayColor].CGColor,
                        (id)[UIColor blackColor].CGColor,
                        (id)[UIColor yellowColor].CGColor,
                        (id)[UIColor blueColor].CGColor,
                        (id)[UIColor redColor].CGColor,
                        (id)[UIColor greenColor].CGColor,
                        (id)[UIColor orangeColor].CGColor,
                        (id)[UIColor brownColor].CGColor,nil];
    [self.layer insertSublayer:gradient1 atIndex:0];
    //第二种填充方式
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGFloat colors[] =
    {
        1,1,1, 1.00,
        1,1,0, 1.00,
        1,0,0, 1.00,
        1,0,1, 1.00,
        0,1,1, 1.00,
        0,1,0, 1.00,
        0,0,1, 1.00,
        0,0,0, 1.00,
    };
    CGGradientRef gradient = CGGradientCreateWithColorComponents
    (rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));//形成梯形，渐变的效果
    CGColorSpaceRelease(rgb);
    //画线形成一个矩形
    //CGContextSaveGState与CGContextRestoreGState的作用
      
    CGContextSaveGState(context);
    CGContextMoveToPoint(context, 220, 90);
    CGContextAddLineToPoint(context, 240, 90);
    CGContextAddLineToPoint(context, 240, 110);
    CGContextAddLineToPoint(context, 220, 110);
    CGContextClip(context);//context裁剪路径,后续操作的路径
    //CGContextDrawLinearGradient(CGContextRef context,CGGradientRef gradient, CGPoint startPoint, CGPoint endPoint,CGGradientDrawingOptions options)
    //gradient渐变颜色,startPoint开始渐变的起始位置,endPoint结束坐标,options开始坐标之前or开始之后开始渐变
    CGContextDrawLinearGradient(context, gradient,CGPointMake
                                (220,90) ,CGPointMake(240,110),
                                kCGGradientDrawsAfterEndLocation);
    CGContextRestoreGState(context);// 恢复到之前的context
      
    //再写一个看看效果
    CGContextSaveGState(context);
    CGContextMoveToPoint(context, 260, 90);
    CGContextAddLineToPoint(context, 280, 90);
    CGContextAddLineToPoint(context, 280, 100);
    CGContextAddLineToPoint(context, 260, 100);
    CGContextClip(context);//裁剪路径
    //说白了，开始坐标和结束坐标是控制渐变的方向和形状
    CGContextDrawLinearGradient(context, gradient,CGPointMake
                                (260, 90) ,CGPointMake(260, 100),
                                kCGGradientDrawsAfterEndLocation);
    CGContextRestoreGState(context);// 恢复到之前的context
      
    //下面再看一个颜色渐变的圆
    CGContextDrawRadialGradient(context, gradient, CGPointMake(300, 100), 0.0, CGPointMake(300, 100), 10, kCGGradientDrawsBeforeStartLocation);
      
      
    //画扇形，也就画圆，只不过是设置角度的大小，形成一个扇形
    aColor = [UIColor colorWithRed:0 green:1 blue:1 alpha:1];
    CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
    //以10为半径围绕圆心画指定角度扇形
    CGContextMoveToPoint(context, 160, 180);
    CGContextAddArc(context, 160, 180, 30,  -60 * M_PI / 180, -120 * M_PI / 180, 1);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke); //绘制路径
  
    //画椭圆
    CGContextAddEllipseInRect(context, CGRectMake(160, 180, 20, 8)); //椭圆
    CGContextDrawPath(context, kCGPathFillStroke);
      
      
    //只要三个点就行跟画一条线方式一样，把三点连接起来
    CGPoint sPoints[3];//坐标点
    sPoints[0] =CGPointMake(100, 220);//坐标1
    sPoints[1] =CGPointMake(130, 220);//坐标2
    sPoints[2] =CGPointMake(130, 160);//坐标3
    CGContextAddLines(context, sPoints, 3);//添加线
    CGContextClosePath(context);//封起来
    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
      
      
    float fw = 180;
    float fh = 280;
      
    CGContextMoveToPoint(context, fw, fh-20);  // 开始坐标右边开始
    CGContextAddArcToPoint(context, fw, fh, fw-20, fh, 10);  // 右下角角度
    CGContextAddArcToPoint(context, 120, fh, 120, fh-20, 10); // 左下角角度
    CGContextAddArcToPoint(context, 120, 250, fw-20, 250, 10); // 左上角
    CGContextAddArcToPoint(context, fw, 250, fw, fh-20, 10); // 右上角
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
      
      
    //二次曲线
    CGContextMoveToPoint(context, 120, 300);//设置Path的起点
    CGContextAddQuadCurveToPoint(context,190, 310, 120, 390);//设置贝塞尔曲线的控制点坐标和终点坐标
    CGContextStrokePath(context);
    //三次曲线函数
    CGContextMoveToPoint(context, 200, 300);//设置Path的起点
    CGContextAddCurveToPoint(context,250, 280, 250, 400, 280, 300);//设置贝塞尔曲线的控制点坐标和控制点坐标终点坐标
    CGContextStrokePath(context);
      
      
      
    UIImage *image = [UIImage imageNamed:@"apple.jpg"];
    [image drawInRect:CGRectMake(60, 340, 20, 20)];//在坐标中画出图片
//    [image drawAtPoint:CGPointMake(100, 340)];//保持图片大小在point点开始画图片，可以把注释去掉看看
    CGContextDrawImage(context, CGRectMake(100, 340, 20, 20), image.CGImage);//使用这个使图片上下颠倒了，参考http://blog.csdn.net/koupoo/article/details/8670024
      
//    CGContextDrawTiledImage(context, CGRectMake(0, 0, 20, 20), image.CGImage);//平铺图
  
}

- (void)initRoundView {
    
    float MScreenScaleY = 0.5;
    //此处不设置self,layer.clipToBounds = YES;属性，否则阴影展示不出来，因为没有设置self,layer.clipToBounds = YES，所以控件四周圆角直接设置self.layer.cornRadious = 10，是无效的，所以必须自己画圆角
    //孔的半径
    CGFloat roundSpace = 6 * MScreenScaleY;
    //孔距离顶部高度
    CGFloat topHeight = (ViewHeight - 6)/2; //ViewHeight * MScreenScaleY;
    //四个角的绘制
    CGFloat roundCorner = 8 * MScreenScaleY;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    //起点
    [bezierPath moveToPoint:CGPointMake(roundCorner , 0)];
    
    //画4周圆角 ----左上圆角
    [bezierPath addArcWithCenter:CGPointMake(roundCorner, roundCorner) radius:roundCorner startAngle:1.5 * M_PI endAngle:M_PI clockwise:NO];
    
    
    
    //画线
    [bezierPath addLineToPoint:CGPointMake(0, topHeight)];
    //左半圆
    [bezierPath addArcWithCenter:CGPointMake(0, topHeight + roundSpace) radius:roundSpace startAngle:1.5 * M_PI endAngle:0.5* M_PI clockwise:YES];
    [bezierPath addLineToPoint:CGPointMake(0, ViewHeight - roundCorner)];
    //画4周圆角 ----左下圆角
    [bezierPath addArcWithCenter:CGPointMake(roundCorner, ViewHeight - roundCorner) radius:roundCorner startAngle:M_PI endAngle: 0.5 *M_PI clockwise:NO];
    
    
    
    [bezierPath addLineToPoint:CGPointMake(ViewWidth - roundCorner, ViewHeight)];
    //画4周圆角 ----右下圆角
    [bezierPath addArcWithCenter:CGPointMake(ViewWidth - roundCorner, ViewHeight - roundCorner) radius:roundCorner startAngle:0.5 *M_PI endAngle: 0.1 *M_PI clockwise:NO];
    //右半圆
    [bezierPath addArcWithCenter:CGPointMake(ViewWidth, topHeight + roundSpace) radius:roundSpace startAngle:0.5* M_PI endAngle:1.5 * M_PI clockwise:YES];
    //    [bezierPath addLineToPoint:CGPointMake(ViewWidth, 0)];
    //    //画4周圆角 ----右上圆角
    [bezierPath addArcWithCenter:CGPointMake(ViewWidth - roundCorner, roundCorner) radius:roundCorner startAngle:0 endAngle: 1.5 * M_PI clockwise:NO];
    [bezierPath addLineToPoint:CGPointMake(roundCorner, 0)];
    
    //    [bezierPath closePath];
    //此处轮廓绘制完毕
    //接下来绘制阴影CAShapeLayer必须借助于UIBezierPath
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.fillColor = UIColor.blueColor.CGColor; // 默认为blackColor//layer填充色
    pathLayer.strokeColor = UIColor.redColor.CGColor; //边框颜色
    pathLayer.path = bezierPath.CGPath;
    //    pathLayer.shadowColor = [UIColor blackColor].CGColor;
    //    // 阴影偏移，默认(0, -3)
    //    pathLayer.shadowOffset = CGSizeMake(0,3);
    //    pathLayer.shadowOpacity = 0.3;
    //    // 阴影半径，默认3
    //    pathLayer.shadowRadius = 3;
    [self.layer addSublayer:pathLayer];
}
//- (void)drawRect:(CGRect)rect
//{
//    float MScreenScaleY =0.5;
//    //圆心 (height - 直径）/2
//    float roundPoint =(self.frame.size.height - 6)/2;
//    //此处不设置self,layer.clipToBounds = YES;属性，否则阴影展示不出来，因为没有设置self,layer.clipToBounds = YES，所以控件四周圆角直接设置self.layer.cornRadious = 10，是无效的，所以必须自己画圆角
//    //孔距离顶部高度
//    CGFloat topHeight = self.frame.size.height;// * MScreenScaleY;
//    //孔的半径
//    CGFloat roundSpace = 6 * MScreenScaleY;
//    //四个角的绘制
//    CGFloat roundCorner = 8 * MScreenScaleY;
//    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
//    //起点
//    [bezierPath moveToPoint:CGPointMake(roundCorner , 0)];
//
//    //画4周圆角 ----左上圆角
//    [bezierPath addArcWithCenter:CGPointMake(roundCorner, roundCorner) radius:roundCorner startAngle:1.5 * M_PI endAngle: M_PI clockwise:NO];
//    //画线
//    [bezierPath addLineToPoint:CGPointMake(0, topHeight)];
//    //左半圆
//    [bezierPath addArcWithCenter:CGPointMake(0, roundPoint/*topHeight + roundSpace*/) radius:roundSpace startAngle:1.5 * M_PI endAngle:0.5* M_PI clockwise:YES];
//    [bezierPath addLineToPoint:CGPointMake(0, ViewHeight - roundCorner)];
//    //画4周圆角 ----左下圆角
//    [bezierPath addArcWithCenter:CGPointMake(roundCorner, ViewHeight - roundCorner) radius:roundCorner startAngle:M_PI endAngle: 0.5 *M_PI clockwise:NO];
//    [bezierPath addLineToPoint:CGPointMake(ViewWidth - roundCorner, ViewHeight)];
//    //画4周圆角 ----右下圆角
//    [bezierPath addArcWithCenter:CGPointMake(ViewWidth - roundCorner, ViewHeight - roundCorner) radius:roundCorner startAngle:0.5 *M_PI endAngle: 0 clockwise:NO];
//    //右半圆
//    [bezierPath addArcWithCenter:CGPointMake(ViewWidth, roundPoint/*topHeight + roundSpace*/) radius:roundSpace startAngle:0.5* M_PI endAngle:1.5 * M_PI clockwise:YES];
//    [bezierPath addLineToPoint:CGPointMake(ViewWidth, 0)];
//    //画4周圆角 ----右上圆角
//    [bezierPath addArcWithCenter:CGPointMake(ViewWidth - roundCorner, roundCorner) radius:roundCorner startAngle:0 endAngle: 1.5 * M_PI clockwise:NO];
//    [bezierPath addLineToPoint:CGPointMake(roundCorner, 0)];
//    [bezierPath closePath];
////此处轮廓绘制完毕
////接下来绘制阴影CAShapeLayer必须借助于UIBezierPath
//    CAShapeLayer *pathLayer = [CAShapeLayer layer];
////    pathLayer.fillColor = [UIColor colorWithRed:0.97 green:0.94 blue:0.87 alpha:1].CGColor; // 默认为blackColor
//    pathLayer.path = bezierPath.CGPath;
////    pathLayer.shadowColor = [UIColor blackColor].CGColor;
////    // 阴影偏移，默认(0, -3)
////    pathLayer.shadowOffset = CGSizeMake(0,3);
////    pathLayer.shadowOpacity = 0.3;
////    // 阴影半径，默认3
////    pathLayer.shadowRadius = 3;
//    [self.layer addSublayer:pathLayer];
//    //此处添加中间虚线
////    [self drawLineOfDashByCAShapeLayer];
//}
- (void)initCustom {
    
    //    即用startAngle、endAngle表示弧度的起点、弧度的终点
    //    弧度的起点 - startAngle： 0.25 * M_PI 或 -1.75 * M_PI
    //    弧度的终点 - endAngle： 0.5 * M_PI 或 -1.5 * M_PI
    //    clockwise，这一步是决定你的弧长怎么样的关键
    //    如果设为YES，圆弧会从弧度的起点沿着顺时针方向画弧，遇到弧度的终点停止，
    CGPoint line_start = CGPointMake(0, 30);
    
    CGPoint line_end = CGPointMake(100, 30);
    
    CGPoint circle_center = CGPointMake(85, 15);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:line_start];
    //
    [path addLineToPoint:line_end];
    
    // 注意线画到这里其实只画了一条直线，但是调用addArcWithCenter方法路径会自动连线到圆弧的起点
    
    [path addArcWithCenter:circle_center radius:10 startAngle:0.25 * M_PI endAngle:- 1.5 * M_PI clockwise:NO];
    
    CAShapeLayer *shapeLayer=[CAShapeLayer layer];
    
    shapeLayer.path = path.CGPath;
    
    shapeLayer.fillColor = [UIColor clearColor].CGColor;//填充颜色
    
    shapeLayer.strokeColor = [UIColor blackColor].CGColor;//边框颜色
    
    shapeLayer.lineCap = @"round";
    
    [self.layer addSublayer:shapeLayer];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

    //系统默认会忽略isUserInteractionEnabled设置为NO、隐藏、或者alpha小于等于0.01的视图

    if (!self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01) {

    if ([self pointInside:point withEvent:event]) {

        for (UIView *subview in [self.subviews reverseObjectEnumerator]) {

            CGPoint convertedPoint = [subview convertPoint:point fromView:self];

            UIView *hitTestView = [subview hitTest:convertedPoint withEvent:event];

            if (hitTestView) {

                return hitTestView;
            }
            
        }
    }
    
    }
    return [super hitTest:point withEvent:event];
}@end
