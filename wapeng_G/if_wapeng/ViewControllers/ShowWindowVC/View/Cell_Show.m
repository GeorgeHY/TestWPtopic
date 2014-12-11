//
//  Cell_Show.m
//  if_wapeng
//
//  Created by 心 猿 on 14-11-10.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
#define DEFAULT_HEIGHT 1 //先这设置为1
#import "Cell_Show.h"
#import "UIButton+FlexSpace.h"
@implementation Cell_Show

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self createContentView];
    }
    return self;
}

-(void)createContentView
{

    self.headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 50, 50)];
    self.headerImageView.layer.masksToBounds = YES;
    self.headerImageView.layer.cornerRadius = 3;
    self.headerImageView.layer.borderWidth = 1;
    self.headerImageView.layer.borderColor = [UIColor grayColor].CGColor;
    self.headerImageView.image = [UIImage imageNamed:@"saga2.jpg"];
    self.headerImageView.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:self.headerImageView];
    
    self.nickNameLbl = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.headerImageView.frame) + 7, 5, kMainScreenWidth / 2, 30)];
    self.nickNameLbl.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.nickNameLbl];
    
    self.babyageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.babyageBtn.frame = CGRectMake(CGRectGetMaxX(self.headerImageView.frame) , 35, kMainScreenWidth / 5, 30);
//    self.babyageBtn.backgroundColor = [UIColor grayColor];
//    self.babyageBtn.backgroundColor = [UIColor redColor];
//    self.babyageBtn.layer.masksToBounds = YES;
//    self.babyageBtn.layer.cornerRadius = 3;
//    self.babyageBtn.layer.borderColor = [UIColor grayColor].CGColor;
//    self.babyageBtn.layer.borderWidth = 1;
    self.babyageBtn.titleLabel.textColor = [UIColor blackColor];
    [self.babyageBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    self.textLabel.font = [UIFont systemFontOfSize:12];
    self.babyageBtn.titleLabel.font = [UIFont systemFontOfSize:12];
     [self.babyageBtn setLayout:OTSImageLeftTitleRightStyle spacing:5];
    [self.contentView addSubview:self.babyageBtn];

    
    self.timeLbl = [[UILabel alloc]initWithFrame:CGRectMake(kMainScreenWidth / 4 * 3 - 20, 3, kMainScreenWidth / 4, 35)];
    self.timeLbl.font = [UIFont systemFontOfSize:13];
    self.timeLbl.textColor = [UIColor grayColor];
    self.timeLbl.textAlignment = NSTextAlignmentRight;
    self.timeLbl.text = @"time";
    [self.contentView addSubview:self.timeLbl];
        
    self.contentLbl = [[TQRichTextView alloc]initWithFrame:CGRectMake(75, CGRectGetMaxY(self.babyageBtn.frame) + 5, kMainScreenWidth - 80, 44)];
   
    self.contentLbl.font = [UIFont systemFontOfSize:14];
    self.contentLbl.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.contentLbl];
    
    self.showImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.headerImageView.frame), CGRectGetMaxY(self.contentLbl.frame) , CGRectGetWidth(self.contentLbl.frame) , DEFAULT_HEIGHT)];
    self.showImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:self.showImageView];
    
    self.remarkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.remarkBtn.frame = CGRectMake(CGRectGetMaxX(self.timeLbl.frame) - 70, CGRectGetMaxY(self.showImageView.frame) + 5, 100, 30);
    self.remarkBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.remarkBtn setImage:[UIImage imageNamed:@"show_item_close"] forState:UIControlStateNormal];
    [self.remarkBtn setImage:[UIImage imageNamed:@"show_item_open"] forState:UIControlStateSelected];
    [self.remarkBtn setLayout:OTSImageLeftTitleRightStyle spacing:2];
    [self.remarkBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.remarkBtn setTitle:@"(111)" forState:UIControlStateNormal];
    [self.contentView addSubview:self.remarkBtn];
    
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
