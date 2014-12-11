//
//  Cell_AllMyShowWindow.m
//  if_wapeng
//
//  Created by 心 猿 on 14-9-15.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "Cell_AllMyShowWindow.h"

@implementation Cell_AllMyShowWindow


-(void)createContentView
{
    self.headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 50, 50)];
    self.headImageView.image = [UIImage imageNamed:@"saga2.jpg"];
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = 5;
    self.headImageView.layer.borderWidth = 1;
    [self.contentView addSubview:self.headImageView];
    
    self.nickNameLbl = [[UILabel alloc]init];
    self.nickNameLbl.frame = CGRectMake(60, 5, 120, 30);
    self.nickNameLbl.text = @"小武妈妈";
    [self.contentView addSubview:self.nickNameLbl];
    
    self.timeLbl = [[UILabel alloc]initWithFrame:CGRectMake(kMainScreenWidth - 130, 10, 130, 20)];
    self.timeLbl.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.timeLbl];
    
    self.genderImageView = [[UIImageView alloc]initWithFrame:CGRectMake(60, self.nickNameLbl.frame.origin.y + self.nickNameLbl.frame.size.height + 5, 30, 20)];
    [self.contentView addSubview:self.genderImageView];
    
    self.babyAgeLbl = [[UILabel alloc]init];
    self.babyAgeLbl.frame = CGRectMake(90, self.nickNameLbl.frame.origin.y + self.nickNameLbl.frame.size.height + 5, 60, 20);
    self.babyAgeLbl.text = @"2岁";
    
    [self.contentView addSubview:self.babyAgeLbl];
    
    self.contentLbl = [[TQRichTextView alloc]initWithFrame:CGRectMake(60, self.genderImageView.frame.origin.y + self.genderImageView.frame.size.height + 10, kMainScreenWidth - 70 , 60)];
    self.contentLbl.backgroundColor = [UIColor whiteColor];
//    self.contentLbl.numberOfLines = 0;
//    self.contentLbl.lineBreakMode = NSLineBreakByCharWrapping;
    [self.contentView addSubview:self.contentLbl];
    
    self.imageScrollView = [[BabyAdView alloc]initWithFrame:CGRectMake(60, self.contentLbl.frame.size.height + self.contentLbl.frame.origin.y, kMainScreenWidth - 100, kMainScreenWidth - 100)];
    [self.contentView addSubview:self.imageScrollView];
    
    self.remarkImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kMainScreenWidth - 100, self.imageScrollView.frame.origin.y + self.imageScrollView.frame.size.height + 5, 25, 25)];
    [self.contentView addSubview:self.remarkImageView];
    
    self.remarkBtn = [[UIButton alloc]initWithFrame:CGRectMake(kMainScreenWidth - 60, self.imageScrollView.frame.origin.y + self.imageScrollView.frame.size.height + 5, 50, 25)];
    
    self.remarkBtn.backgroundColor = [UIColor orangeColor];
    
//    self.remarkImageView.backgroundColor = [UIColor blueColor];
//    self.remarkBtn.text = @"(10)";
    
    [self.contentView addSubview:self.remarkBtn];
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 1;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor grayColor].CGColor;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self createContentView];
    }
    return self;
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
