//
//  Cell_Mail.m
//  if_wapeng
//
//  Created by 早上好 on 14-10-23.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "Cell_Mail.h"
#import "TQRichTextView.h"
@implementation Cell_Mail

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.headerIV = [[UIImageView alloc]  initWithFrame:CGRectMake(10, 10, 60, 60)];
        [self.contentView  addSubview:self.headerIV];
        self.name = [[UILabel alloc]  initWithFrame:CGRectMake(CGRectGetMaxX(self.headerIV.frame) + 5, 10, kMainScreenWidth - CGRectGetMaxX(self.headerIV.frame) + 5, 20)];
        self.name.backgroundColor = [UIColor greenColor];
        [self.contentView  addSubview:self.name];
        self.mailContent  = [[TQRichTextView alloc]  initWithFrame:CGRectMake(self.headerIV.frame.origin.x + self.headerIV.frame.size.width + 10, CGRectGetMaxY(self.name.frame) + 5, self.contentView.frame.size.width - (self.headerIV.frame.origin.x+self.headerIV.frame.size.width + 20), self.contentView.frame.size.height)];
        self.mailContent.backgroundColor = [UIColor whiteColor];
        self.mailContent.font = [UIFont boldSystemFontOfSize:19];
        [self.contentView addSubview:self.mailContent];
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
