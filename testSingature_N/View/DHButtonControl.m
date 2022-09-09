//
//  DHButtonControl.m
//  testSingature
//
//  Created by rilakkuma on 2022/6/17.
//  Copyright © 2022 zk. All rights reserved.
//

#import "DHButtonControl.h"

@implementation DHButtonControl
//centerInset 图片与文字上下间距
//updownset 图片文字整体距上距下高
- (instancetype)initWithFrame:(CGRect)frame centerInset:(CGFloat)centerInset updownInset:(CGFloat)updownInset imageName:(NSString *)imageName labelString:(NSString *)labelString labelFont:(CGFloat)font {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        CGFloat imageEquelheight = frame.size.height - updownInset * 2 - font - centerInset;
        CGFloat imageLeft = (frame.size.width - imageEquelheight)/2;
        _contentImageView = [[UIImageView alloc]initWithFrame:CGRectMake(imageLeft, updownInset, imageEquelheight, imageEquelheight)];
        _contentImageView.contentMode = UIViewContentModeScaleAspectFit;
        _contentImageView.image = [UIImage imageNamed:imageName];
        [self addSubview:_contentImageView];
        
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(_contentImageView.frame)  + centerInset, frame.size.width - 10,font)];
        _contentLabel.font = [UIFont systemFontOfSize:font];
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.text = labelString;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_contentLabel];
    }
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    return YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
