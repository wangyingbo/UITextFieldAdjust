//
//  UITextField+YBAdjust.m
//  testTableViewCell
//
//  Created by EDZ on 2017/3/22.
//  Copyright © 2017年 王颖博. All rights reserved.
//

#import "UITextField+YBAdjust.h"
#import <objc/runtime.h>

static const void *kName = "autoAdjustDelegate";

NSString * kYBTextFieldNotification = @"YBTextFieldNotificationId";


@implementation UITextField (YBAdjust)
@dynamic autoAdjustDelegate;

#pragma mark - 字符串类型的动态绑定



- (id<YBTextFieldAdjustDelegate>)autoAdjustDelegate
{
    
    return objc_getAssociatedObject(self, kName);
}

- (void)setAutoAdjustDelegate:(id<YBTextFieldAdjustDelegate>)autoAdjustDelegate
{
    objc_setAssociatedObject(self, kName, autoAdjustDelegate, OBJC_ASSOCIATION_ASSIGN);
}


- (void)setAutoAdjust: (BOOL)autoAdjust
{
    if (autoAdjust) {
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(keyboardWillShow:) name: UIKeyboardWillShowNotification object: nil];
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(keyboardWillHide:) name: UIKeyboardWillHideNotification object: nil];
    } else {
        [[NSNotificationCenter defaultCenter] removeObserver: self];
    }
}

- (void)keyboardWillShow: (NSNotification *)notification
{
    if (self.isFirstResponder) {
        CGPoint relativePoint = [self convertPoint: CGPointZero toView: [UIApplication sharedApplication].keyWindow];
        
        CGFloat keyboardHeight = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
        CGFloat actualHeight = CGRectGetHeight(self.frame) + relativePoint.y + keyboardHeight;
        CGFloat overstep = actualHeight - CGRectGetHeight([UIScreen mainScreen].bounds) + 1;
        if (overstep > 0) {
            CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
            CGRect frame = [UIScreen mainScreen].bounds;
            frame.origin.y -= overstep;
            [UIView animateWithDuration: duration delay: 0 options: UIViewAnimationOptionCurveLinear animations: ^{
                
                if (self.autoAdjustDelegate && [self.autoAdjustDelegate respondsToSelector:@selector(getTheTextFieldRootView)])
                {
                    UIView *view = [self.autoAdjustDelegate getTheTextFieldRootView];
                    view.frame = frame;
                }
                else
                {
                    //[UIApplication sharedApplication].keyWindow.frame = frame;
                    UIViewController *vc = [self getCurrentVC];
                    vc.view.frame = frame;
                    
                }
                
                
            } completion: nil];
        }
    }
}

- (void)keyboardWillHide: (NSNotification *)notification
{
    if (self.isFirstResponder) {
        CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        CGRect frame = [UIScreen mainScreen].bounds;
        [UIView animateWithDuration: duration delay: 0 options: UIViewAnimationOptionCurveLinear animations: ^{
            if (self.autoAdjustDelegate && [self.autoAdjustDelegate respondsToSelector:@selector(getTheTextFieldRootView)])
            {
                UIView *view = [self.autoAdjustDelegate getTheTextFieldRootView];
                view.frame = frame;
            }
            else
            {
                //[UIApplication sharedApplication].keyWindow.frame = frame;
                UIViewController *vc = [self getCurrentVC];
                vc.view.frame = frame;
                
            }
            
        } completion: nil];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //        UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    
    return result;
}

@end
