//
//  TestVC.m
//  testTableViewCell
//
//  Created by EDZ on 2017/5/16.
//  Copyright © 2017年 王颖博. All rights reserved.
//

#import "TestVC.h"
#import "SecondVC.h"



@interface TestVC ()

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    SecondVC *second = [[SecondVC alloc]init];
    [self.navigationController pushViewController:second animated:YES];
}

@end
