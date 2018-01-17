//
//  UITextView+YBManager.m
//  testTableViewCell
//
//  Created by 王迎博 on 2018/1/17.
//  Copyright © 2018年 王颖博. All rights reserved.
//

#import "UITextView+YBManager.h"
#import <objc/runtime.h>

// 高度变化的block
static const void *showBlockKey = &showBlockKey;
// 高度变化的block
static const void *hiddenBlockKey = &hiddenBlockKey;


@implementation UITextView (YBManager)

- (UIKeyboardWillShowBlock)showBlock
{
    UIKeyboardWillShowBlock showBlock_ = objc_getAssociatedObject(self, showBlockKey);
    return showBlock_;
}

- (void)setShowBlock:(UIKeyboardWillShowBlock)showBlock
{
    objc_setAssociatedObject(self, showBlockKey, showBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIKeyboardWillHiddenBlock)hiddenBlock
{
    UIKeyboardWillHiddenBlock hiddenBlock_ = objc_getAssociatedObject(self, hiddenBlockKey);
    return hiddenBlock_;
}

- (void)setHiddenBlock:(UIKeyboardWillHiddenBlock)hiddenBlock
{
    objc_setAssociatedObject(self, hiddenBlockKey, hiddenBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setManager: (BOOL)autoAdjust
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
        CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        CGFloat keyboardHeight = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
        CGFloat actualHeight = CGRectGetHeight(self.frame) + relativePoint.y + keyboardHeight;
        CGFloat overstep = actualHeight - CGRectGetHeight([UIScreen mainScreen].bounds) + 1;
        if (overstep > 0) {
            CGRect frame = [UIScreen mainScreen].bounds;
            frame.origin.y -= overstep;
            
        }
        if (self.showBlock) {
            self.showBlock(keyboardHeight, overstep, duration);
        }
    }
}

- (void)keyboardWillHide: (NSNotification *)notification
{
    if (self.isFirstResponder) {
        CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        CGFloat keyboardHeight = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
        if (self.hiddenBlock) {
            self.hiddenBlock(keyboardHeight, duration);
        }
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

/**
 通过responder找到当前vc
 
 @return 当前vc
 */
- (UIViewController *)viewController {
    UIResponder *responder = self;
    while (![responder isKindOfClass:[UIViewController class]]) {
        responder = [responder nextResponder];
        if (nil == responder) {
            break;
        }
    }
    return (UIViewController *)responder;
}
@end
