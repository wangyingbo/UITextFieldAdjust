//
//  InputCell.m
//  edianzu
//
//  Created by EDZ on 2017/1/18.
//  Copyright © 2017年 edianzu. All rights reserved.
//

#import "EDZStorageInputCell.h"

#define textField_H 30*VIEWLAYOUT_H
#define VIEWLAYOUT_W  FULL_SCREEN_WIDTH/375
#define VIEWLAYOUT_H  FULL_SCREEN_HEIGHT/667

#define FULL_SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define FULL_SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height

@implementation EDZStorageInputCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    NSString *ID = identifier;
//    EDZStorageInputCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (!cell) {
//        cell = [[EDZStorageInputCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//    }
    
    
    /**因为表格较少，可以取消表格复用*/
    EDZStorageInputCell *cell = [[EDZStorageInputCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        UITextField *textField = [[UITextField alloc]init];
        textField.textColor = [UIColor grayColor];
        //textField.backgroundColor = [UIColor greenColor];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.font = [UIFont systemFontOfSize:13.*VIEWLAYOUT_H];
        [self addSubview:textField];
        self.textField = textField;
        
        UILabel *textLabel = [[UILabel alloc]init];
        textLabel.textAlignment = NSTextAlignmentLeft;
        textLabel.textColor = [UIColor grayColor];
        [self addSubview:textLabel];
        self.textLB = textLabel;
        
        UIButton *sweepButton = [[UIButton alloc]init];
        [sweepButton setImage:[UIImage imageNamed:@"sweep"] forState:UIControlStateNormal];
        sweepButton.hidden = YES;
        [self addSubview:sweepButton];
        self.sweepButton = sweepButton;
        
        UIImageView *takePhotoButton = [[UIImageView alloc]init];
        [takePhotoButton setImage:[UIImage imageNamed:@"take_photo"]];
        //takePhotoButton.contentMode = UIViewContentModeScaleAspectFill;
        takePhotoButton.userInteractionEnabled = YES;
        takePhotoButton.hidden = YES;
        [self addSubview:takePhotoButton];
        self.takePhotoButton = takePhotoButton;
        
    }
    
    return self;
}

- (void)setTextFieldPlaceholder:(NSString *)textFieldPlaceholder
{
    _textFieldPlaceholder = textFieldPlaceholder;
    self.textField.placeholder = textFieldPlaceholder;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textField.frame = CGRectMake(self.frame.size.width/3 +20*VIEWLAYOUT_W, self.frame.size.height/2 - textField_H/2, self.frame.size.width*2/3- 65*VIEWLAYOUT_W, textField_H);
    
    self.textLB.frame = CGRectMake(12, self.frame.size.height/2 - textField_H/2, self.frame.size.width/3-12, textField_H);
    
    self.sweepButton.frame = CGRectMake(self.frame.size.width - 40*VIEWLAYOUT_W, self.frame.size.height/2- 35*VIEWLAYOUT_H/2, 35*VIEWLAYOUT_W, 35*VIEWLAYOUT_H);
    
    self.takePhotoButton.frame = CGRectMake(self.frame.size.width/3 + 20*VIEWLAYOUT_W, self.frame.size.height/2 - 30*VIEWLAYOUT_H/2, 40*VIEWLAYOUT_W, 30*VIEWLAYOUT_H);
}

@end
