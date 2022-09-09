//
//  YDYContactsCollectionCell.m
//  meetCRM
//
//  Created by jabraknight on 2022/2/24.
//  Copyright © 2022 edianyun. All rights reserved.
//

#import "YDYContactsCollectionCell.h"
#import "Masonry.h"

@interface YDYContactsCollectionCell()
/** 头像 */
@property (nonatomic, strong) UIImageView *iconImg;
/** 姓名 */
@property (nonatomic, strong) UILabel *nameLB;
/** 交友状态 */
@property (nonatomic, strong) UIButton *friendStatus;
/** 状态 */
@property (nonatomic, strong) UILabel *stateLB;
@end

@implementation YDYContactsCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createUI];
    }
    return self;
}

- (void)setNsyerrt:(NSString *)nsyerrt{
    _nsyerrt = nsyerrt;
    _stateLB.text = _nsyerrt;
}
- (void)createUI{
//    [self.contentView addSubview:self.iconImg];
    [self.contentView addSubview:self.stateLB];
    [self.contentView addSubview:self.nameLB];
    [self.contentView addSubview:self.friendStatus];

    [self makeConstraints];

}



- (void)makeConstraints{
//    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(5);
//        make.left.mas_equalTo(16);
//        make.height.mas_equalTo(64);
//        make.width.mas_equalTo(64);
//    }];

    [self.stateLB setContentCompressionResistancePriority:UILayoutPriorityRequired
    forAxis:UILayoutConstraintAxisHorizontal];
    [self.stateLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.contentView).with.offset(0);
        make.right.equalTo(self.contentView).with.offset(0);
        make.height.mas_equalTo(15);
    }];
    
    [self.nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.stateLB.mas_bottom).offset(7.5);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(11);
    }];
    
    [self.friendStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLB.mas_bottom).offset(7.5);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(11);
    }];
}

//- (void)friengStateClick{
//    if (self.buttonClick) {
//        self.buttonClick(self.model.ID);
//    }
//}

#pragma mark - Lazy
- (UIImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc]init];
        _iconImg.backgroundColor = UIColor.redColor;
    }
    return _iconImg;
}

- (UILabel *)stateLB {
    if (!_stateLB) {
        _stateLB = [[UILabel alloc]init];
//        _stateLB.backgroundColor = Color16(@"5964EA");
        _stateLB.numberOfLines = 1;
        _stateLB.font = [UIFont systemFontOfSize:14];
//        _stateLB.textColor = Color16(@"FFFFFF");
    }
    return _stateLB;
}

- (UILabel *)nameLB {
    if (!_nameLB) {
        _nameLB = [[UILabel alloc]init];
        _nameLB.text = @" ";
//        _nameLB.font = FONTSIZE_DEFAULT(11);
//        _nameLB.textColor = Color16(@"333333");
    }
    return _nameLB;
}

- (UIButton *)friendStatus {
    if (!_friendStatus) {
        _friendStatus = [[UIButton alloc]init];
//        _friendStatus.titleLabel.font = FONTSIZE_DEFAULT(11);
//        _friendStatus.titleLabel.textColor = Color16(@"0089FF");
//        [_friendStatus addTarget:self action:@selector(friengStateClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _friendStatus;
}

@end
