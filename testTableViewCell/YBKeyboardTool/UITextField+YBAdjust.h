//
//  UITextField+YBAdjust.h
//  testTableViewCell
//
//  Created by EDZ on 2017/3/22.
//  Copyright © 2017年 王颖博. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YBTextFieldAdjustDelegate <NSObject>

@optional
- (UIView *)getTheTextFieldRootView;

@end

@interface UITextField (YBAdjust)

@property (nonatomic, weak) id<YBTextFieldAdjustDelegate> autoAdjustDelegate;

/**自动适应*/
- (void)setAutoAdjust: (BOOL)autoAdjust;

@end
