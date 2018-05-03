//
//  YBKeyBoardTool.h
//  testTableViewCell
//
//  Created by 王迎博 on 2017/12/28.
//  Copyright © 2017年 王颖博. All rights reserved.
//
//  让view的高度变化，view的底部=(屏幕高度-键盘高度)
//  若是tableView或collectionView，高度=(屏幕高度-键盘高度)，origin.y = 0，类似安卓效果

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface YBKeyBoardTool : NSObject

typedef void(^UIKeyboardWillShowBlock)(CGFloat keyboardHeight, CGFloat overstep, CGFloat duration);
typedef void(^UIKeyboardWillHiddenBlock)(CGFloat keyboardHeight, CGFloat duration);

@property (nonatomic, copy) UIKeyboardWillShowBlock showBlock;
@property (nonatomic, copy) UIKeyboardWillHiddenBlock hiddenBlock;

/**
 topMargin:此参数只在调用setHandlerView:withShow:withHidden方法且方法的参数view为scrollView的子类（UITableView||UICollectionView）时使用
 */
@property (nonatomic, assign) CGFloat topMargin;
/**
 overV:此参数只在调用setHandlerView:withShow:withHidden方法且方法的参数view为scrollView的子类（UITableView||UICollectionView）时使用
 */
@property (nonatomic, assign) CGFloat overV;


- (void)setDefaultHandler:(UIView *)view;

/**
 监控键盘

 @param view 如果textView或textField是加在collectionView或者tableView上，则传collectionView或者tableView，否则传本身或者父类view
 @param Show 弹出时回调
 @param Hidden 隐藏时回调s
 */
- (void)setHandlerView:(UIView *)view withShow:(UIKeyboardWillShowBlock)Show withHidden:(UIKeyboardWillHiddenBlock)Hidden;


+ (void)resignFirstResponder;
@end
