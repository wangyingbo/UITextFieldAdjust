//
//  YBKeyBoardTool.h
//  testTableViewCell
//
//  Created by 王迎博 on 2017/12/28.
//  Copyright © 2017年 王颖博. All rights reserved.
//
//  让tableView的高度变化，使高度等于屏幕高度减去键盘高度，类似安卓效果

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YBKeyBoardTool : NSObject
- (void)setDefaultHandler:(UIView *)view;
@end
