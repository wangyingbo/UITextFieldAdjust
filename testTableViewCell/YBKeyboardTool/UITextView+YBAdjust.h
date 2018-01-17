//
//  UITextView+YBAdjust.h
//  testTableViewCell
//
//  Created by 王迎博 on 2018/1/17.
//  Copyright © 2018年 王颖博. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YBTextViewAdjustDelegate <NSObject>

@optional
- (UIView *)getTheTextViewRootView;

@end

@interface UITextView (YBAdjust)
@property (nonatomic, weak) id<YBTextViewAdjustDelegate> autoAdjustDelegate;
/**自动适应*/
- (void)setAutoAdjust: (BOOL)autoAdjust;
@end
