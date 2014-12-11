//
//  Cell_ActivityDetail.m
//  if_wapeng
//
//  Created by 心 猿 on 14-9-1.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "Cell_ActivityDetail.h"
#import "MyParserTool.h"
@implementation Cell_ActivityDetail

- (void)awakeFromNib
{
    // Initialization code
    self.headerImage.layer.masksToBounds = YES;
    self.headerImage.layer.cornerRadius = 4;
    self.headerImage.layer.borderWidth = 1;
    
//    self.detailLabel.numberOfLines = 0;
    self.detailLabel.textColor = [UIColor grayColor];
//    self.detailLabel.lineBreakMode = NSLineBreakByCharWrapping;
    self.detailLabel.font = [UIFont systemFontOfSize:13];
    self.detailLabel.backgroundColor = [UIColor whiteColor];
    self.detailLabel.text = @"【海上生明月，天涯共此时。情人怨遥夜，竟夕起相思！海上生明月，天涯共此时。情人怨遥夜，竟夕起相思！海上生明月，天涯共此时。情人怨遥夜，竟夕起相思！】";
    self.headerImage.image = [UIImage imageNamed:@"saga.jpg"];
    
    self.cNameLabel.textColor = [UIColor redColor];
    
    
//    self.imageView1.image = [UIImage imageNamed:@"saga2.jpg"];
////    self.imageView1.layer.masksToBounds = YES;
////    self.imageView1.layer.cornerRadius = 4;
////    self.imageView1.layer.borderWidth = 1;
//    self.imageView2.image = [UIImage imageNamed:@"saga2.jpg"];
////    self.imageView2.layer.masksToBounds = YES;
////    self.imageView2.layer.cornerRadius = 4;
////    self.imageView2.layer.borderWidth = 1;
//    self.imageView3.image = [UIImage imageNamed:@"saga2.jpg"];
////    self.imageView3.layer.masksToBounds = YES;
////    self.imageView3.layer.cornerRadius = 4;
////    self.imageView3.layer.borderWidth = 1;
//    self.imageView4.image = [UIImage imageNamed:@"saga2.jpg"];
////    self.imageView4.layer.masksToBounds = YES;
////    self.imageView4.layer.cornerRadius = 4;
////    self.imageView4.layer.borderWidth = 1;
//    self.imageView5.image = [UIImage imageNamed:@"saga2.jpg"];
////    self.imageView5.layer.masksToBounds = YES;
////    self.imageView5.layer.cornerRadius = 4;
////    self.imageView5.layer.borderWidth = 1;
//    self.imageView6.image = [UIImage imageNamed:@"saga2.jpg"];
////    self.imageView6.layer.masksToBounds = YES;
////    self.imageView6.layer.cornerRadius = 4;
////    self.imageView6.layer.borderWidth = 1;
//    self.imageView7.image = [UIImage imageNamed:@"saga2.jpg"];
////    self.imageView7.layer.masksToBounds = YES;
////    self.imageView7.layer.cornerRadius = 4;
////    self.imageView7.layer.borderWidth = 1;
//    self.imageView8.image = [UIImage imageNamed:@"saga2.jpg"];
////    self.imageView8.layer.masksToBounds = YES;
////    self.imageView8.layer.cornerRadius = 4;
////    self.imageView8.layer.borderWidth = 1;
//    self.imageView9.image = [UIImage imageNamed:@"saga2.jpg"];
////    self.imageView9.layer.masksToBounds = YES;
////    self.imageView9.layer.cornerRadius = 4;
////    self.imageView9.layer.borderWidth = 1;
}

-(void)layoutSubviews
{
    CGRect frame = self.imgContentView.frame;
    frame.origin.y = CGRectGetMaxY(self.detailLabel.frame) + 5;
    self.imgContentView.frame = frame;
    
    frame = self.discussLabel.frame;
    frame.origin.y = CGRectGetMaxY(self.imgContentView.frame) + 5;
    self.discussLabel.frame = frame;
    
    frame = self.praiseBtn.frame;
    frame.origin.y = CGRectGetMaxY(self.imgContentView.frame) + 5;
    self.praiseBtn.frame = frame;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
