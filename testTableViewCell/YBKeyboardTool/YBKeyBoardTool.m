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
    CGFloat keyboardHeight = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    CGRect frame = self.frame;
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    frame.size.height = self.frame.size.height - keyboardHeight;
    
    [UIView animateWithDuration: duration delay: 0 options: UIViewAnimationOptionCurveLinear animations: ^{
        self.view.frame = frame;
    } completion: nil];
    
    if (self.showBlock) {
        self.showBlock(keyboardHeight, 0, duration);
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
