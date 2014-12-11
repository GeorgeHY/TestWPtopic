//
//  Cell_BabyDatum.m
//  if_wapeng
//
//  Created by 早上好 on 14-9-18.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "Cell_BabyDatum.h"

@implementation Cell_BabyDatum

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.leftTitle = [[UILabel alloc]  initWithFrame:CGRectMake(10, 5, 80, 20)];
        self.rightLable = [[UILabel alloc]  initWithFrame:CGRectMake(self.contentView.frame.size.width - 80, 5, 80, 20)];
        [self.contentView  addSubview:self.leftTitle];
        [self.contentView  addSubview:self.rightLable];
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
