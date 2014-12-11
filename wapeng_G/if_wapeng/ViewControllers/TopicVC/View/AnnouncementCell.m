//
//  AnnouncementCell.m
//  if_wapeng
//
//  Created by 心 猿 on 14-9-1.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "AnnouncementCell.h"

@implementation AnnouncementCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView * v = [[UIImageView alloc]  initWithFrame:CGRectMake(5, 0, 150, 100)];
        [v setImage:[UIImage imageNamed:@"ann_ boby.png"]];
        [self.contentView  addSubview:v];
        self.imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
        
        [self.contentView  addSubview:self.imageView1];
        self.lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 60, 20)];
        self.lable.textAlignment = NSTextAlignmentCenter;
        [self.contentView  addSubview:self.lable];
        self.lable.font = [UIFont systemFontOfSize:14];
        self.imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(85, 10, 60, 60)];
        
        [self.contentView  addSubview:self.imageView2];
        self.lable2 = [[UILabel alloc] initWithFrame:CGRectMake(90, 80, 60, 20)];
        self.lable2.font = [UIFont systemFontOfSize:14];
        self.lable2.textAlignment = NSTextAlignmentCenter;
        [self.contentView  addSubview:self.lable2];
        
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
