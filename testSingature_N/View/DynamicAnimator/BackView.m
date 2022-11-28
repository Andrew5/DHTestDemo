//
//  BackView.m
//  LocalNoticeAndBadge
//
//  Created by jabraknight on 2021/1/25.
//  Copyright © 2021 CBayel. All rights reserved.
//

#import "BackView.h"
@interface BackView()
@property(nonatomic, assign) CGPoint point1;
@property(nonatomic, assign) CGPoint point2;
@end
@implementation BackView


- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor purpleColor].CGColor);
    CGContextSetLineWidth(context, 4.0);
    CGContextMoveToPoint(context, _point1.x, _point1.y);
    CGContextAddLineToPoint(context, _point2.x, _point2.y);
    
    CGContextStrokePath(context);
  
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
