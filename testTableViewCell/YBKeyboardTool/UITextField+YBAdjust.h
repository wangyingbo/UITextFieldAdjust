//
//  UITextField+YBAdjust.h
//  testTableViewCell
//
//  Created by EDZ on 2017/3/22.
//  Copyright © 2017年 王颖博. All rights reserved.
//
//  通过代理实现代理返回值的view高度自变化

#import <UIKit/UIKit.h>

extern NSString *kYBTextFieldNotification;

@protocol YBTextFieldAdjustDelegate <NSObject>

@optional
- (UIView *)getTheTextFieldRootView;

@end

@interface UITextField (YBAdjust)

@property (nonatomic, weak) id<YBTextFieldAdjustDelegate> autoAdjustDelegate;

/**自动适应*/
- (void)setAutoAdjust: (BOOL)autoAdjust;

@end
