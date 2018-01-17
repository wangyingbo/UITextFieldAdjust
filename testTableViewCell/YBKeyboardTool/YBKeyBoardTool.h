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

typedef void(^UIKeyboardWillShowBlock)(CGFloat keyboardHeight, CGFloat overstep, CGFloat duration);
typedef void(^UIKeyboardWillHiddenBlock)(CGFloat keyboardHeight, CGFloat duration);

@property (nonatomic, copy) UIKeyboardWillShowBlock showBlock;
@property (nonatomic, copy) UIKeyboardWillHiddenBlock hiddenBlock;
- (void)setDefaultHandler:(UIView *)view;
- (void)setHandlerView:(UIView *)view withShow:(UIKeyboardWillShowBlock)Show withHidden:(UIKeyboardWillHiddenBlock)Hidden;

@end
