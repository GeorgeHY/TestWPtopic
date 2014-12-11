//
//  HotLeftTVCell.m
//  if_wapeng
//
//  Created by 心 猿 on 14-8-8.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "HotLeftTVCell.h"

@implementation HotLeftTVCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.im = [[UIImageView alloc]  initWithFrame:CGRectMake(0, 0, 5, 30)];
        self.im.backgroundColor = [UIColor blueColor];
        self.im.hidden = YES;
        [self.contentView  addSubview:self.im];
        self.title = [[UILabel alloc]  initWithFrame:CGRectMake(20, 10, 200, 30)];
//        self.title.backgroundColor = [UIColor redColor];
        [self.title setFont:[UIFont italicSystemFontOfSize:20]];
//        self.title.textAlignment =
        [self.contentView addSubview:self.title];
        self.title.textColor = [UIColor whiteColor];
        self.mview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
//        self.mview.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.mview];
        
        
    }
    return self;
}

- (void)awakeFromNi
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
