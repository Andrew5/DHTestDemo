//
//  AutoCellTableViewCell.h
//  testSingature_N
//
//  Created by rilakkuma on 2022/9/25.
//

#import <UIKit/UIKit.h>
#import "DHTestMessage.h"
#import "UITableViewCell+CellShadows.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^SystemTableViewCellBlock)(void);

@interface AutoCellTableViewCell : UITableViewCell
@property (nonatomic, strong) DHTestMessage *systemMessage;

/** 方法block回调 */
@property (nonatomic, copy) SystemTableViewCellBlock openCloseBlock;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setupCellData:(DHTestMessage *)m;
@end

NS_ASSUME_NONNULL_END
