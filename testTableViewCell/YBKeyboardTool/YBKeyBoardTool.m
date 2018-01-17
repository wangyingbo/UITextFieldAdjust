//
//  YBKeyBoardTool.m
//  testTableViewCell
//
//  Created by 王迎博 on 2017/12/28.
//  Copyright © 2017年 王颖博. All rights reserved.
//

#import "YBKeyBoardTool.h"
#import <UIKit/UIKit.h>
#import "UIResponder+YBFirstResponder.h"

@interface YBKeyBoardTool ()
@property (nonatomic, strong) UIView *view;
@property (nonatomic, assign) CGRect frame;
@property (nonatomic, assign) CGPoint relativePoint;
@end

@implementation YBKeyBoardTool

+ (void)resignFirstResponder
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (void)setDefaultHandler:(UIView *)view
{
    self.view = view;
    self.frame = view.frame;
    CGPoint relativePoint = [self.view convertPoint: CGPointZero toView: [UIApplication sharedApplication].keyWindow];
    self.relativePoint = relativePoint;
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(keyboardWillShow:) name: UIKeyboardWillShowNotification object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(keyboardWillHide:) name: UIKeyboardWillHideNotification object: nil];
}

- (void)setHandlerView:(UIView *)view withShow:(UIKeyboardWillShowBlock)show withHidden:(UIKeyboardWillHiddenBlock)hidden
{
    self.view = view;
    self.frame = view.frame;
    CGPoint relativePoint = [self.view convertPoint: CGPointZero toView: [UIApplication sharedApplication].keyWindow];
    self.relativePoint = relativePoint;
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(keyboardWillShow:) name: UIKeyboardWillShowNotification object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(keyboardWillHide:) name: UIKeyboardWillHideNotification object: nil];
    
    self.showBlock = show;
    self.hiddenBlock = hidden;
}

- (void)keyboardWillShow: (NSNotification *)notification
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    //此种方法调用私有api，不可取
    //UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    //UIView *firstResponder = [keyWindow performSelector:@selector(firstResponder)];
#pragma clang diagnostic pop
    //键盘弹出时拿到全局的第一响应者
    UIView *firstResponder = (UIView *)[UIResponder currentFirstResponder];
    
    CGFloat keyboardHeight = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGPoint firstResponderRelativePoint = [firstResponder convertPoint: CGPointZero toView: [UIApplication sharedApplication].keyWindow];
    CGFloat firstResponderOverstep = CGRectGetHeight(firstResponder.frame) + firstResponderRelativePoint.y - (CGRectGetHeight([UIScreen mainScreen].bounds)-keyboardHeight);
    
    CGRect frame = self.frame;

    if (firstResponderOverstep>1e-6) {
        frame.origin.y -= firstResponderOverstep;
    }
    
    if ([self.view isKindOfClass:[UIScrollView class]]) {
        if (self.frame.size.height>(CGRectGetHeight([UIScreen mainScreen].bounds) - keyboardHeight)) {
            frame.origin.y = 0;
            frame.size.height = CGRectGetHeight([UIScreen mainScreen].bounds) - keyboardHeight;
        }else {
            frame.origin.y = CGRectGetHeight([UIScreen mainScreen].bounds) - keyboardHeight - self.frame.size.height;
        }
    }
    
    [UIView animateWithDuration: duration delay: 0 options: UIViewAnimationOptionCurveLinear animations: ^{
        self.view.frame = frame;
    } completion: nil];
    
    if (self.showBlock) {
        self.showBlock(keyboardHeight, firstResponderOverstep, duration);
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
