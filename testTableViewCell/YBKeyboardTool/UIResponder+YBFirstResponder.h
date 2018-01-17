//
//  UIResponder+YBFirstResponder.h
//  testTableViewCell
//
//  Created by 王迎博 on 2018/1/17.
//  Copyright © 2018年 王颖博. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (YBFirstResponder)
//核心原理是：  - (BOOL)sendAction:(SEL)action to:(id)target from:(id)sender forEvent:(UIEvent *)event
/**使用时只需要对UIResponder类调用该类方法即可获得当前第一响应者*/
+ (id)currentFirstResponder;
//如果只希望让第一响应者取消其第一响应者的状态，则可以做如下操作：  [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];

@end
