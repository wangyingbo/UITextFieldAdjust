//
//  SecondVC.m
//  testTableViewCell
//
//  Created by EDZ on 2017/5/16.
//  Copyright © 2017年 王颖博. All rights reserved.
//

#import "SecondVC.h"
#import "EDZStorageInputCell.h"
#import "YBKeyboardHeader.h"


#define EDZInputStorageCellId @"defaultCellId"


@interface SecondVC ()<YBTextFieldAdjustDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak) EDZStorageInputCell *editingCell;
@property (nonatomic, strong) YBKeyBoardTool *keyBoardTool;

@end

@implementation SecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建tableView
    [self createTableView];
    
//    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(keyboardWillShow:) name: UIKeyboardWillShowNotification object: nil];
//    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(keyboardWillHide:) name: UIKeyboardWillHideNotification object: nil];
    
    /**用YBKeyBoardTool去做*/
    YBKeyBoardTool *keyboardTool = [[YBKeyBoardTool alloc]init];
    [keyboardTool setDefaultHandler:self.view];
    self.keyBoardTool = keyboardTool;
}

-(void)dealloc
{
    NSLog(@"vc里移除通知");
    [[NSNotificationCenter defaultCenter] removeObserver: self];
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
    CGPoint relativePoint = [self.editingCell.textField convertPoint: CGPointZero toView: [UIApplication sharedApplication].keyWindow];
    
    CGFloat keyboardHeight = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    CGFloat actualHeight = CGRectGetHeight(self.editingCell.textField.frame) + relativePoint.y + keyboardHeight;
    CGFloat overstep = actualHeight - CGRectGetHeight([UIScreen mainScreen].bounds) + 5;
    if (overstep > 0) {
        CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        CGRect frame = [UIScreen mainScreen].bounds;
        frame.origin.y -= overstep;
        [UIView animateWithDuration: duration delay: 0 options: UIViewAnimationOptionCurveLinear animations: ^{
            self.view.frame = frame;
        } completion: nil];
    }
}

- (void)keyboardWillHide: (NSNotification *)notification
{
    NSLog(@"keyboard will hide");
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = [UIScreen mainScreen].bounds;
    [UIView animateWithDuration: duration delay: 0 options: UIViewAnimationOptionCurveLinear animations: ^{
        self.view.frame = frame;
    } completion: nil];

}


#pragma mark -- tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


/**
 *  header的数量
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EDZStorageInputCell *cell = [EDZStorageInputCell cellWithTableView:tableView withIdentifier:EDZInputStorageCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textField.delegate = self;
    cell.textLB.text = [NSString stringWithFormat:@"第%ld行",indexPath.row];
    [cell layoutIfNeeded];
    
    /**用UITextField+YBAdjust.h去做*/
//    cell.textField.autoAdjustDelegate = self;
//    [cell.textField setAutoAdjust:YES];
    
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
    //[self.editingCell.textField resignFirstResponder];
}


#pragma mark - UIScrollViewDelegate
- (UIView *)getTheTextFieldRootView
{
    return self.view;
}

@end
