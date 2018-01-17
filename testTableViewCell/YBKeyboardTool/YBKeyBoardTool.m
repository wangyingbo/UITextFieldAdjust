//
//  YBKeyBoardTool.m
//  testTableViewCell
//
//  Created by 王迎博 on 2017/12/28.
//  Copyright © 2017年 王颖博. All rights reserved.
//

#import "YBKeyBoardTool.h"
#import <UIKit/UIKit.h>

@interface YBKeyBoardTool ()
@property (nonatomic, strong) UIView *view;
@property (nonatomic, assign) CGRect frame;
@end

@implementation YBKeyBoardTool


- (void)setDefaultHandler:(UIView *)view
{
    self.view = view;
    self.frame = view.frame;
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(keyboardWillShow:) name: UIKeyboardWillShowNotification object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(keyboardWillHide:) name: UIKeyboardWillHideNotification object: nil];
}

- (void)setHandlerView:(UIView *)view withShow:(UIKeyboardWillShowBlock)show withHidden:(UIKeyboardWillHiddenBlock)hidden
{
    self.view = view;
    self.frame = view.frame;
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(keyboardWillShow:) name: UIKeyboardWillShowNotification object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(keyboardWillHide:) name: UIKeyboardWillHideNotification object: nil];
    
    self.showBlock = show;
    self.hiddenBlock = hidden;
}

- (void)keyboardWillShow: (NSNotification *)notification
{
    CGPoint relativePoint = [self.view convertPoint: CGPointZero toView: [UIApplication sharedApplication].keyWindow];
    CGFloat keyboardHeight = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGFloat overstep = CGRectGetHeight(self.frame) + relativePoint.y - (CGRectGetHeight([UIScreen mainScreen].bounds)-keyboardHeight);
    
    CGRect frame = self.frame;
    if (overstep>1e-6) {
        if (self.frame.size.height>(CGRectGetHeight([UIScreen mainScreen].bounds) - keyboardHeight)) {
            if ([self.view isKindOfClass:[UIScrollView class]]) {
                frame.origin.y = 0;
                frame.size.height = CGRectGetHeight([UIScreen mainScreen].bounds) - keyboardHeight;
            }else {
                frame.origin.y = CGRectGetHeight([UIScreen mainScreen].bounds) - keyboardHeight - self.frame.size.height;
            }
        }else {
            frame.origin.y = CGRectGetHeight([UIScreen mainScreen].bounds) - keyboardHeight - self.frame.size.height;
        }
    }
    
    [UIView animateWithDuration: duration delay: 0 options: UIViewAnimationOptionCurveLinear animations: ^{
        self.view.frame = frame;
    } completion: nil];
    
    if (self.showBlock) {
        self.showBlock(keyboardHeight, overstep, duration);
    }
    
}

- (void)keyboardWillHide: (NSNotification *)notification
{
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGFloat keyboardHeight = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    
    [UIView animateWithDuration: duration delay: 0 options: UIViewAnimationOptionCurveLinear animations: ^{
        self.view.frame = self.frame;
    } completion: nil];
    
    if (self.hiddenBlock) {
        self.hiddenBlock(keyboardHeight, duration);
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}



@end
