//
//  Cell_SellerAciti2.h
//  if_wapeng
//
//  Created by 心 猿 on 14-9-7.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
//带有分割线的cell
#import <UIKit/UIKit.h>
#import "TQRichTextView.h"
#import "FJFastTextView.h"
@interface Cell_SellerAciti2 : UITableViewCell
@property (nonatomic, strong) UIImageView * headerImage;//头像
@property (nonatomic, strong) TQRichTextView * mainLabel;//标题
@property (nonatomic, strong) UILabel * detailLabel;//详情
//@property (nonatomic, strong) UIImageView * locationImageView;//地图小图标
//@property (nonatomic, strong) UILabel * joinLabel;//多少个人参与
@property (nonatomic, strong) UIImageView * mainView;//为了调整 cell之间的间距
//@property (nonatomic, strong) UIImageView * positionIV;

@property (nonatomic, strong) UILabel * userLabel;//name

@property (nonatomic, strong) UIView * headerMainView;//上边条
@property (nonatomic, strong) UILabel * topLabel;//排名
@property (nonatomic, strong) UILabel * replayLabel;
@property (nonatomic, strong) UILabel * firlabel;//熟人
@property (nonatomic, strong) UIImageView * line;//虚线
@end
