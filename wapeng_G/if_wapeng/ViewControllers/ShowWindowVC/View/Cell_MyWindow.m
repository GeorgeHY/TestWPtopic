//
//  Cell_MyWindow.m
//  if_wapeng
//
//  Created by 心 猿 on 14-10-19.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
#define DEFAULT_HEIGHT 1 //先这设置为1
#import "Cell_MyWindow.h"
#import "UIButton+FlexSpace.h"
@implementation Cell_MyWindow

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
    self.nickNameLbl = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, kMainScreenWidth / 3, 35)];
    self.nickNameLbl.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.nickNameLbl];
    
    self.timeLbl = [[UILabel alloc]initWithFrame:CGRectMake(kMainScreenWidth / 2, 10, kMainScreenWidth / 4, 35)];
    self.timeLbl.font = [UIFont systemFontOfSize:13];
    self.timeLbl.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.timeLbl];

    self.deleteBtn = [[UIButton alloc]init];
    self.deleteBtn.frame = CGRectMake(self.timeLbl.frame.origin.x + self.timeLbl.frame.size.width -10, 12, 80, 30);
    [self.deleteBtn setLayout:OTSImageLeftTitleRightStyle spacing:2];
    self.deleteBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    self.deleteBtn.titleLabel.textColor = [UIColor grayColor];
    [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [self.deleteBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [self.deleteBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.deleteBtn setImage:[UIImage imageNamed:@"show_item_delete"] forState:UIControlStateNormal];
    [self.deleteBtn setImage:[UIImage imageNamed:@"show_item_delete2"] forState:UIControlStateHighlighted];
    [self.contentView addSubview:self.deleteBtn];
    
    self.contentLbl = [[TQRichTextView alloc]initWithFrame:CGRectMake(50, self.nickNameLbl.frame.size.height + self.nickNameLbl.frame.origin.y, kMainScreenWidth - 80, 44)];
    self.contentLbl.font = [UIFont systemFontOfSize:14];
    self.contentLbl.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.contentLbl];
    
    
    self.showImageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(self.contentLbl.frame) , CGRectGetWidth(self.contentLbl.frame) , DEFAULT_HEIGHT)];
    self.showImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:self.showImageView];
    
    self.remarkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.remarkBtn.frame = CGRectMake(self.timeLbl.frame.origin.x + self.timeLbl.frame.size.width -20, self.contentLbl.frame.size.height + self.contentLbl.frame.origin.y + 5, 100, 30);
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
