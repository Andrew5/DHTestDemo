//
//  UIImageView+loadImage.m
//  GLPageUIScrollView
//
//  Created by 高磊 on 2017/3/6.
//  Copyright © 2017年 高磊. All rights reserved.
//

#import "UIImageView+loadImage.h"
#import "UIImageView+WebCache.h"
@implementation UIImageView (loadImage)

//设置图片
- (void)setImageViewContent:(id)image
{
    if ([image isKindOfClass:[UIImage class]])
    {
        self.image = (UIImage *)image;
    }
    else if ([image hasPrefix:@"http://"] ||
             [image hasPrefix:@"https://"] ||
             [image rangeOfString:@"/"].location != NSNotFound)
    {
        [self sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"banner"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (!image)
            {
                [self setImage:[UIImage imageNamed:@"banner"]];
            }
        }];
    }
    else if([image isKindOfClass:[NSString class]])
    {
        self.image = [UIImage imageNamed:image];
    }
}

@end
