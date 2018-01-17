//
//  UITextField+YBManager.h
//  testTableViewCell
//
//  Created by 王迎博 on 2018/1/15.
//  Copyright © 2018年 王颖博. All rights reserved.
//
//  通过block传出键盘超过输入框的超过的值，然后自己调整控件的值

#import <UIKit/UIKit.h>
#import "YBKeyBoardTool.h"


@interface UITextField (YBManager)
@property (nonatomic, copy) UIKeyboardWillShowBlock showBlock;
@property (nonatomic, copy) UIKeyboardWillHiddenBlock hiddenBlock;

/**自动适应*/
- (void)setManager: (BOOL)autoAdjust;
@end
