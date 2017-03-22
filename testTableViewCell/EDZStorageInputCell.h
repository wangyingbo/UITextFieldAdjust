//
//  InputCell.h
//  edianzu
//
//  Created by EDZ on 2017/1/18.
//  Copyright © 2017年 edianzu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDZStorageInputCell : UITableViewCell

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, copy) NSString *textFieldPlaceholder;
@property (nonatomic, strong) UILabel *textLB;
@property (nonatomic, strong) UIButton *sweepButton;
@property (nonatomic, strong) UIImageView *takePhotoButton;


+ (instancetype)cellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;
@end
