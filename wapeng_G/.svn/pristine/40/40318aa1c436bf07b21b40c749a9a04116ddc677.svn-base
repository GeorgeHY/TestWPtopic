//
//  AnnouncementDetailCell.m
//  if_wapeng
//
//  Created by 心 猿 on 14-9-3.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "AnnouncementDetailCell.h"

@implementation AnnouncementDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView * iv = [[UIImageView alloc]  initWithFrame:CGRectMake(10, 5, self.contentView.frame.size.width - 20, 65)];
        [iv  setImage:[UIImage imageNamed:@"annDetailbg.png"]];
        [self.contentView addSubview:iv];
        self.headerIv = [[UIImageView alloc]  initWithFrame:CGRectMake(15, 12, 50, 50)];
        [self.headerIv setImage:[UIImage imageNamed:@"annDetailbg.png"]];
        [self.contentView addSubview:self.headerIv];
        UIImageView * locationIv = [[UIImageView alloc]  initWithFrame:CGRectMake(self.headerIv.frame.size.width + 20, 15, 17, 20)];
        [locationIv  setImage:[UIImage imageNamed:@"location.png"]];
        [self.contentView addSubview:locationIv];
        self.locationL = [[UILabel alloc]  initWithFrame:CGRectMake(self.headerIv.frame.size.width + 42, 15, 70,20)];
        self.locationL.textAlignment = NSTextAlignmentLeft;
        self.locationL.font = [UIFont boldSystemFontOfSize:10];
        [self.contentView addSubview:self.locationL];
    
        self.name = [[UILabel alloc]  initWithFrame:CGRectMake(self.headerIv.frame.size.width + 22, 40, 70, 20)];
        [self.contentView addSubview:self.name];
        
        UIImageView * countIv = [[UIImageView alloc]  initWithFrame:CGRectMake(self.contentView.frame.size.width / 2 + 20, 15, 15,17)];
        [countIv setImage:[UIImage imageNamed:@"ann_count.png"]];
        [self.contentView addSubview:countIv];
        self.countL = [[UILabel alloc]  initWithFrame:CGRectMake(self.contentView.frame.size.width / 2 + 40, 15, 50,17)];
        self.countL.font = [UIFont boldSystemFontOfSize:14];
        [self.contentView addSubview:self.countL];
        
        UILabel * lable = [[UILabel alloc]  initWithFrame:CGRectMake(self.contentView.frame.size.width / 2 + 40 + 50, 15, 50,17)];
        lable.text = @"熟人点评";
        lable.textAlignment = NSTextAlignmentLeft;
        lable.font = [UIFont boldSystemFontOfSize:10];
        [self.contentView  addSubview:lable];
        
        int with = 21;
        self.littleIv0 = [[UIImageView alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width / 2 + 20, 38, with, with)];

        [self.contentView addSubview:self.littleIv0];
        
        self.littleIv1 = [[UIImageView alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width / 2 + 20 + (with *1 ), 38, with, with)];

        [self.contentView addSubview:self.littleIv1];

        self.littleIv2 = [[UIImageView alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width / 2 + 20 + (with *2 ), 38, with, with)];

        [self.contentView addSubview:self.littleIv2];
        self.littleIv3 = [[UIImageView alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width / 2 + 20 + (with *3), 38, with, with)];

        [self.contentView addSubview:self.littleIv3];
        
        self.littleIv4 = [[UIImageView alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width / 2 + 20 + (with * 4 ),  38, with, with)];
        [self.contentView addSubview:self.littleIv4];
        
        self.littleIv5 = [[UIImageView alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width / 2 + 20 +(with *5 ), 38, with, with)];
        [self.contentView addSubview:self.littleIv5];
        
        
        self.markHot = [[UIImageView alloc]  initWithFrame:CGRectMake(self.contentView.frame.size.width - 20 - 10, 5, 20, 20)];
        [self.markHot  setImage:[UIImage imageNamed:@"hot.png"]];
        [self.contentView  addSubview:self.markHot];
        
      
        
        
    }
    return self;
}

- (void)awakeFromNib
{

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    
}

@end
