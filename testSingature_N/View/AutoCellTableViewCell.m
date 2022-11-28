//
//  AutoCellTableViewCell.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/9/25.
//

#import "AutoCellTableViewCell.h"
#import <Masonry.h>

@interface AutoCellTableViewCell()<UITextViewDelegate>

@property (nonatomic, strong) UIView *orderRootView;
///标题
@property (nonatomic, strong) UILabel *titlesLabel;
///时间
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UITextView *contentLabel;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UIView *splitlineView;


@end

@implementation AutoCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"AutoCellTableViewCell";
    AutoCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[AutoCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.iconImageView = [[UIImageView alloc]init];
        self.iconImageView.layer.masksToBounds = YES;
        self.iconImageView.userInteractionEnabled = YES;
        self.iconImageView.layer.cornerRadius = 20.0f;
        [self.contentView addSubview:self.orderRootView];
        [self.orderRootView addSubview:self.timeLabel];
        [self.orderRootView addSubview:self.titlesLabel];
        [self.orderRootView addSubview:self.contentLabel];
        [self.orderRootView addSubview:self.iconImageView];
        [self.orderRootView addSubview:self.splitlineView];

        [self makeConstraints];

    }
    return  self;
}
- (void)setSystemMessage:(DHTestMessage *)systemMessage{
    _systemMessage = systemMessage;
    self.timeLabel.text     = _systemMessage.pathname;
    self.titlesLabel.text   = _systemMessage.name;
//    self.contentLabel.text  = _systemMessage.fragment;
    NSString *contentStr = _systemMessage.fragment;

    NSString *suffixStr = @""; //添加的后缀按钮文本（收起或展开）
    CGFloat H = _systemMessage.titleActualH; //文本的高度，默认为实际高度
    if (_systemMessage.titleActualH > _systemMessage.titleMaxH) {
        //文本实际高度>最大高度，需要添加后缀
        if (_systemMessage.isOpen) {
            //文本已经展开，此时后缀为“收起”按钮
            suffixStr = @"收起";
            contentStr = [NSString stringWithFormat:@"%@ %@", contentStr, suffixStr];
            H = _systemMessage.titleActualH;
        } else {
            //文本已经收起，此时后缀为“展开/全文”按钮
            //需要对文本进行截取，将“...展开”添加到我们限制的展示文字的末尾
            NSUInteger numCount = 2; //这是cell收起状态下期望展示的最大行数
            CGFloat W = 284;//[UIScreen mainScreen].bounds.size.width-30; //这里是文本展示的宽度
            NSString *tempStr = [self stringByTruncatingString:contentStr suffixStr:@"...展开" font:[UIFont systemFontOfSize:14] forLength:W * numCount];
            contentStr = tempStr;
            suffixStr = @"展开";
            H = _systemMessage.titleMaxH;
        }
    }

    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:contentStr attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    self.contentLabel.linkTextAttributes = @{};

        //给富文本的后缀添加点击事件
        if(suffixStr.length >0){
            NSRange range3 = [contentStr rangeOfString:suffixStr];
            [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor systemBlueColor] range:range3];//[UIColor colorWithHexString:@"#000000"]
            NSString *valueString3 = [[NSString stringWithFormat:@"didOpenClose://%@", suffixStr] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
            [attStr addAttribute:NSLinkAttributeName value:valueString3 range:range3];
        }
    self.contentLabel.attributedText = attStr;
    
//    i % 2 == 0 ? @"123123123.png" : @""
    [self.iconImageView setImage:[UIImage imageNamed:systemMessage.host]];//@"123123123.png"]];
    NSLog(@"图片：%@",systemMessage.host);

}
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if ([[URL scheme] isEqualToString:@"didOpenClose"]) {
        //点击了“展开”或”收起“，通过代理或者block回调，让持有tableView的控制器去刷新单行Cell
        if (self.openCloseBlock) {
            self.openCloseBlock();
        }
        return NO;
    }
    return YES;
}

/// 将文本按长度度截取并加上指定后缀
/// @param str 文本
/// @param suffixStr 指定后缀
/// @param font 文本字体
/// @param length 文本长度
- (NSString*)stringByTruncatingString:(NSString *)str suffixStr:(NSString *)suffixStr font:(UIFont *)font forLength:(CGFloat)length {
    if (!str) return nil;
    if (str  && [str isKindOfClass:[NSString class]]) {
        for (int i=(int)[str length] - (int)[suffixStr length]; i< [str length];i = i - (int)[suffixStr length]){
            NSString *tempStr = [str substringToIndex:i];
            CGSize size = [tempStr sizeWithAttributes:@{NSFontAttributeName:font}];
            if(size.width < length){
                tempStr = [NSString stringWithFormat:suffixStr, tempStr];
                CGSize size1 = [tempStr sizeWithAttributes:@{NSFontAttributeName:font}];
                if(size1.width < length){
                    str = tempStr;
                    break;
                }
            }
        }
    }
    return str;
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    [self makeConstraints];
}
- (void)makeConstraints {
//    [super layoutSubviews];
    
    [self.orderRootView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).mas_equalTo(12);
        make.right.equalTo(self.contentView).mas_equalTo(-12);
        make.top.equalTo(self.contentView).mas_equalTo(8);
        make.bottom.equalTo(self.contentView).mas_equalTo(-10);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orderRootView.mas_left).offset(0);
        make.top.equalTo(self.orderRootView.mas_top).mas_equalTo(0);
        make.height.mas_equalTo(20);
    }];
    
    [self.titlesLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];

    [self.titlesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orderRootView.mas_left).offset(0);
        make.top.equalTo(self.timeLabel.mas_bottom).mas_equalTo(10);
        make.height.mas_equalTo(20);
    }];
    
    
    //两个标签都是自动适应，会发生挤压，所以设置优先级，让value优先级低，就可以往下撑开多行布局
    [self.contentLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
//    [self.contentLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titlesLabel.mas_right).offset(12);
        make.right.equalTo(self.orderRootView.mas_right).offset(0);
        make.top.equalTo(self.titlesLabel.mas_top);
    }];
    [self.contentLabel layoutIfNeeded];
    NSLog(@"输出--%f",self.contentLabel.frame.size.width);
    //图片
//    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.orderRootView).offset(12);
//        make.top.equalTo(self.titlesLabel.mas_bottom).offset(12);
//        make.height.offset(64);
//        make.width.offset(64);
//
//    }];
    
    [self.splitlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orderRootView);
        make.right.equalTo(self.orderRootView.mas_right);

        make.top.equalTo(self.contentLabel.mas_bottom).offset(12);
        make.height.offset(10);
        make.bottom.equalTo(self.orderRootView.mas_bottom);

    }];
 
    
}
- (UIView *)orderRootView {
    if (nil == _orderRootView) {
        _orderRootView = [[UIView alloc]init];
        _orderRootView.clipsToBounds = YES;
        _orderRootView.layer.masksToBounds = YES;
        _orderRootView.layer.cornerRadius = 5;
        _orderRootView.backgroundColor = [UIColor whiteColor];
        _orderRootView.userInteractionEnabled = YES;
    }
    return _orderRootView;
}
- (UILabel *)titlesLabel {
    if (nil == _titlesLabel) {
        _titlesLabel = [[UILabel alloc]init];
        _titlesLabel.backgroundColor = [UIColor clearColor];
        _titlesLabel.numberOfLines = 1;
        _titlesLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _titlesLabel.font = [UIFont boldSystemFontOfSize:16];
        _titlesLabel.textColor = [UIColor redColor];
    }
    return _titlesLabel;
}

- (UILabel *)timeLabel {
    if (nil == _timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.numberOfLines = 1;
        _timeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _timeLabel.font = [UIFont boldSystemFontOfSize:16];
        _timeLabel.textColor = [UIColor orangeColor];
    }
    return _timeLabel;
}

- (UITextView *)contentLabel {
    if (nil == _contentLabel) {
        _contentLabel = [[UITextView alloc]init];
        _contentLabel.backgroundColor = [UIColor clearColor ];
        _contentLabel.delegate = self;
//        _contentLabel.numberOfLines = 0;
//        _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _contentLabel.font = [UIFont boldSystemFontOfSize:14];
        _contentLabel.textColor = [UIColor greenColor];
    }
    return _contentLabel;
}
- (UIView *)splitlineView {
    if (!_splitlineView) {
        _splitlineView = [[UIView alloc]init];
        _splitlineView.backgroundColor = UIColor.brownColor;
    }
    return _splitlineView;
}
- (UIImageView *)iconImageView {
    if (nil == _iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
    }
    return _iconImageView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
