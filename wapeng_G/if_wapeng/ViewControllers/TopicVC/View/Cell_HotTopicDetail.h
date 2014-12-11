//
//  Cell_HotTopicDetail.h
//  if_wapeng
//
//  Created by 早上好 on 14-9-11.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TQRichTextView.h"
@interface Cell_HotTopicDetail : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *day;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet TQRichTextView *content;
@property (weak, nonatomic) IBOutlet UIImageView *header;
@property (weak, nonatomic) IBOutlet UILabel *headerNmae;
@property (weak, nonatomic) IBOutlet UILabel *age;

@property (weak, nonatomic) IBOutlet UIButton *address;

@property (weak, nonatomic) IBOutlet UIImageView *image1;

@property (weak, nonatomic) IBOutlet UIImageView *image2;


@property (weak, nonatomic) IBOutlet UIImageView *image3;

@property (weak, nonatomic) IBOutlet UIImageView *image4;
@property (weak, nonatomic) IBOutlet UIImageView *image5;

@property (weak, nonatomic) IBOutlet UIImageView *image6;

@property (weak, nonatomic) IBOutlet UIImageView *image7;

@property (weak, nonatomic) IBOutlet UIImageView *image8;

@property (weak, nonatomic) IBOutlet UIImageView *image9;

@property (weak, nonatomic) IBOutlet UILabel *good;
@property (weak, nonatomic) IBOutlet UILabel *msg;



@property (weak, nonatomic) IBOutlet UIView *imageGroup;


@property (weak, nonatomic) IBOutlet UIImageView *clickGood;



@end
