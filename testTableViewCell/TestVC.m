//
//  TestVC.m
//  testTableViewCell
//
//  Created by EDZ on 2017/5/16.
//  Copyright © 2017年 王颖博. All rights reserved.
//

#import "TestVC.h"
#import "SecondVC.h"
#import "UIResponder+YBFirstResponder.h"


@interface TestVC ()

@end

@implementation TestVC


/**
 默认是NO，重写为YES

 @return YES
 */
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
}

- (void)click
{
    SecondVC *second = [[SecondVC alloc]init];
    [self.navigationController pushViewController:second animated:YES];

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 重写canBecomeFirstResponder后，能拿到第一响应者
    id res = [UIResponder currentFirstResponder];
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIView *firstResponder = [keyWindow performSelector:@selector(firstResponder)];
    NSLog(@"响应者————————%@",[res class]);
    NSLog(@"响应者————————%@",[firstResponder class]);
    
    SecondVC *second = [[SecondVC alloc]init];
    [self.navigationController pushViewController:second animated:YES];
}

@end
