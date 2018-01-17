//
//  UIResponder+YBFirstResponder.m
//  testTableViewCell
//
//  Created by 王迎博 on 2018/1/17.
//  Copyright © 2018年 王颖博. All rights reserved.
//

#import "UIResponder+YBFirstResponder.h"

static __weak id currentFirstResponder;

@implementation UIResponder (YBFirstResponder)
+ (id)currentFirstResponder {
    currentFirstResponder = nil;
    // 通过将target设置为nil，让系统自动遍历响应链
    // 从而响应链当前第一响应者响应我们自定义的方法
    [[UIApplication sharedApplication] sendAction:@selector(findFirstResponder:)
                                               to:nil
                                             from:nil
                                         forEvent:nil];
    return currentFirstResponder;
}
- (void)findFirstResponder:(id)sender {
    // 第一响应者会响应这个方法，并且将静态变量currentFirstResponder设置为自己
    currentFirstResponder = self;
}

@end
