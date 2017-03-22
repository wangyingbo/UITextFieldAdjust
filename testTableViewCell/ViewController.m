//
//  ViewController.m
//  testTableViewCell
//
//  Created by EDZ on 2017/2/3.
//  Copyright © 2017年 王颖博. All rights reserved.
//

#import "ViewController.h"
#import "EDZStorageInputCell.h"
#import "UITextField+YBAdjust.h"



#define EDZInputStorageCellId @"defaultCellId"


@interface ViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak) EDZStorageInputCell *editingCell;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建tableView
    [self createTableView];
}


/**
 *  创建tableView
 */
- (void)createTableView
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.backgroundColor = [UIColor whiteColor];
    //去掉底部多余的表格线。
    [tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [self.tableView registerClass:[EDZStorageInputCell class] forCellReuseIdentifier:EDZInputStorageCellId];
}

#pragma mark - Notification
- (void)keyboardWillShow: (NSNotification *)notification
{
    NSLog(@"keyboard will show");
}

- (void)keyboardWillHide: (NSNotification *)notification
{
    NSLog(@"keyboard will hide");
}


#pragma mark -- tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}


/**
 *  header的数量
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EDZStorageInputCell *cell = [EDZStorageInputCell cellWithTableView:tableView withIdentifier:EDZInputStorageCellId];
    
    cell.textField.delegate = self;
    [cell.textField setAutoAdjust:YES];
    cell.textLB.text = [NSString stringWithFormat:@"第%ld行",indexPath.row];
    [cell layoutIfNeeded];
    
    return cell;
}


#pragma mark -- tableViewDelegate
/**
 *  在willDisplayCell里面处理数据能优化tableview的滑动流畅性
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
/**
 *  header的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

/**
 *  直接设置header的名字
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"header-%ld",(long)section];
}


#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    EDZStorageInputCell *editingCell = (EDZStorageInputCell *)textField.superview;
    self.editingCell = editingCell;
    
}

- (BOOL)textFieldShouldReturn: (UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.editingCell.textField resignFirstResponder];
}

@end
