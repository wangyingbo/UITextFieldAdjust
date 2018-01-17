//
//  UITextField+YBManager.h
//  testTableViewCell
//
//  Created by 王迎博 on 2018/1/15.
//  Copyright © 2018年 王颖博. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIKeyboardWillShowBlock)(CGFloat keyboardHeight, CGFloat overstep, CGFloat duration);
typedef void(^UIKeyboardWillHiddenBlock)(CGFloat keyboardHeight, CGFloat duration);
@interface UITextField (YBManager)
@property (nonatomic, copy) UIKeyboardWillShowBlock showBlock;
@property (nonatomic, copy) UIKeyboardWillHiddenBlock hiddenBlock;

/**自动适应*/
- (void)setAutoAdjust: (BOOL)autoAdjust;
@end
