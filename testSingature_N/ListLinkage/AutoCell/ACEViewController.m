//
//  ACEViewController.m
//  ACEExpandableTextCellDemo
//
//  Created by Stefano Acerbetti on 6/5/13.
//  Copyright (c) 2013 Stefano Acerbetti. All rights reserved.
//

#import "ACEViewController.h"
#import "ACEExpandableTextCell.h"

@interface ACEViewController ()<ACEExpandableTableViewDelegate> {
    CGFloat _cellHeight[2];
}

@property (nonatomic, strong) NSMutableArray *cellData;
@property (nonatomic, strong) NSMutableArray *labelStrArray;


@end

@implementation ACEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.cellData = [NSMutableArray arrayWithArray:@[ @"Existing text1",@"Existing text2",@"Existing text3",@"Existing text4",@"Existing text5",@"Existing text6",@"Existing text7",@"Existing text8",@"Existing text9", @"10"]];
    self.labelStrArray = [NSMutableArray arrayWithArray:@[ @"编辑 text",@"写作业 text",@"看电视 text",@"答发多少 text",@"答发的啥饭 text",@"史蒂夫 text",@"阿水淀粉 text",@"阿道夫 text",@"阿水淀粉 text", @"23"]];

}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ACEExpandableTextCell *cell = [tableView expandableTextCellWithId:@"cellId"];
    cell.text = [self.cellData objectAtIndex:indexPath.row];
    cell.textView.placeholder = @"Placeholder";
    cell.labelSetStr = [self.labelStrArray objectAtIndex:indexPath.row];

    return cell;
}


#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MAX(50.0, _cellHeight[indexPath.row]);
}

- (void)tableView:(UITableView *)tableView updatedHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath
{
    _cellHeight[indexPath.row] = height;
    NSLog(@"当前行：%f，输入内容--%f",height,_cellHeight[indexPath.row]);

}

- (void)tableView:(UITableView *)tableView updatedText:(NSString *)text atIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"当前行：%ld，输入内容--%@",indexPath.row,text);
//    self.cellData = [self.cellData mutableCopy];
    [self.cellData replaceObjectAtIndex:indexPath.row withObject:text];
//    if (self.cellData == nil) {
//        NSLog(@"当前行：%ld，输入内容--%@",indexPath.row,text);
//
//    NSLog(@"输出--%@",self.cellData);
//    [self.cellData removeObjectAtIndex:indexPath.row];
//    NSLog(@"输出--%@",self.cellData);
//    [self.cellData insertObject:text atIndex:indexPath.row];
//    NSLog(@"输出--%@",self.cellData);
}

@end
