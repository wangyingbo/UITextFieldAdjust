//
//  UITextView+YBManager.h
//  testTableViewCell
//
//  Created by 王迎博 on 2018/1/17.
//  Copyright © 2018年 王颖博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBKeyBoardTool.h"

@interface UITextView (YBManager)
@property (nonatomic, copy) UIKeyboardWillShowBlock showBlock;
@property (nonatomic, copy) UIKeyboardWillHiddenBlock hiddenBlock;

/**自动适应*/
- (void)setManager: (BOOL)autoAdjust;
@end
