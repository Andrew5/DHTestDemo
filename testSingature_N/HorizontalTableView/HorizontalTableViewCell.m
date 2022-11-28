//
//  HorizontalTableViewCell.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/10/30.
//
#import "HorizontalTableViewCell.h"

@implementation HorizontalTableViewCell

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super init];
    if (self) {
        self.reuseIdentifier = reuseIdentifier;
        CGRect fram =CGRectMake(10, 10, 30, 30);
        UILabel *lb = [[UILabel alloc]initWithFrame:fram];
        lb.text = @"2";
        lb.textColor = [UIColor blackColor];
        lb.font = [UIFont systemFontOfSize:20];
        lb.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lb];
    }
    return self;
}

- (NSString *)reuseIdentifier{
    if (!_reuseIdentifier) {
        return @"";
    }
    return _reuseIdentifier;
}

- (void)prepareForReuse{
    
}

@end
