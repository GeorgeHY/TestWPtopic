//
//  TalkColumnCell.m
//  if_wapeng
//
//  Created by 早上好 on 14-9-11.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "TalkColumnCell.h"

@implementation TalkColumnCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.top = [[UILabel alloc]  initWithFrame:CGRectMake(10, 5, self.contentView.frame.size.width, 20)];
        self.top.font = [UIFont boldSystemFontOfSize:12];
        self.top.text = @"置顶";
        [self.contentView  addSubview:self.top];

        UIImageView * bg = [[UIImageView alloc]  initWithFrame:CGRectMake(5,self.top.frame.origin.y + self.top.frame.size.height + 2, self.contentView.frame.size.width - 10, 100)];
        bg.image = [UIImage imageNamed:@"cellBGView.png"];
        [self.contentView  addSubview:bg];
        self.content = [[UILabel alloc]  initWithFrame:CGRectMake(10, self.top.frame.origin.y + self.top.frame.size.height + 2 + 10,self.contentView.frame.size.width - 10 - 100, 60)];
//        self.content.backgroundColor =[UIColor orangeColor];
        self.content.font = [UIFont boldSystemFontOfSize:14];
        self.content.numberOfLines = 2;//表示label可以多行显示
        self.content.lineBreakMode = NSLineBreakByWordWrapping;
        [self.contentView  addSubview:self.content];
        self.header = [[UIImageView alloc]  initWithFrame:CGRectMake(bg.frame.origin.x + bg.frame.size.width - 80, self.top.frame.origin.y + self.top.frame.size.height + 2 + 10, 60, 60)];
//        self.header.backgroundColor = [UIColor redColor];
        self.header.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView  addSubview:self.header];
        self.headerName = [[UILabel alloc]  initWithFrame:CGRectMake(bg.frame.origin.x + bg.frame.size.width - 90,  self.top.frame.origin.y +self.top.frame.size.height + self.header.frame.size.height + 10 , 80, 20)];
        self.headerName.font = [UIFont boldSystemFontOfSize:14];
        self.headerName.textAlignment = NSTextAlignmentLeft;
//        self.headerName.backgroundColor = [UIColor greenColor];
        [self.contentView  addSubview:self.headerName];
        
        self.reply = [[UILabel alloc]  initWithFrame:CGRectMake(10,
                                                                self.top.frame.origin.y + self.top.frame.size.height + self.header.frame.size.height + 10
                                                                , 60, 20)];
        self.reply.font = [UIFont boldSystemFontOfSize:12];
//        self.reply.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:self.reply];
        self.friends = [[UILabel alloc]  initWithFrame:CGRectMake(self.reply.frame.origin.x + self.reply.frame.size.width +5,self.top.frame.origin.y + self.top.frame.size.height + self.header.frame.size.height + 10, 60, 20)];
//        self.friends.backgroundColor = [UIColor redColor];
        self.friends.font = [UIFont boldSystemFontOfSize:12];
        [self.contentView addSubview:self.friends];
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
