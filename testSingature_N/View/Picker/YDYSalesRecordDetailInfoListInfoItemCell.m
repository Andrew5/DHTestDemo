//
//  YDYSalesRecordDetailInfoListInfoItemCell.m
//  meetCRM
//
//  Created by 史晓义 on 2022/3/8.
//  Copyright © 2022 edianyun. All rights reserved.
//

#import "YDYSalesRecordDetailInfoListInfoItemCell.h"
#import "Masonry.h"

@implementation YDYSalesRecordDetailInfoListInfoItemCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.icon];
        [self.contentView addSubview:self.deleteButton];
        
        [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(self.contentView);
            make.width.height.equalTo(@(20));
        }];
    }
    return self;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_deleteButton setImage:[UIImage imageNamed:@"showmore"] forState:(UIControlStateNormal)];
        _deleteButton.hidden = YES;
        [_deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _deleteButton;
}

- (void)deleteButtonClick {
    if (self.deleteHandle != nil) {
        self.deleteHandle();
    }
}

- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.layer.masksToBounds = YES;
        _icon.layer.cornerRadius = 4;
        _icon.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _icon;
}

@end
