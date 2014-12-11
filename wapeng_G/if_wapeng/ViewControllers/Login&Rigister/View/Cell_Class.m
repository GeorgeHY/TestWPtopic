//
//  Cell_Class.m
//  if_wapeng
//
//  Created by 心 猿 on 14-8-29.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "Cell_Class.h"

@implementation Cell_Class

- (void)awakeFromNib
{
    // Initialization code
    self.leftImageView.layer.masksToBounds = YES;
    self.leftImageView.layer.cornerRadius = 4;
    self.leftImageView.layer.borderWidth = 1;
    
    self.rightImageView.layer.masksToBounds = YES;
    self.rightImageView.layer.cornerRadius = 4;
    self.rightImageView.layer.borderWidth = 1;
    self.petName1.numberOfLines=0;
    self.petName2.numberOfLines=0;
    self.mainLabel.numberOfLines=0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
