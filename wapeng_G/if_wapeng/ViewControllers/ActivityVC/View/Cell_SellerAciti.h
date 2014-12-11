//
//  Cell_SellerAciti.h
//  if_wapeng
//
//  Created by 心 猿 on 14-9-3.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TQRichTextView.h"
#import "FJFastTextView.h"
@interface Cell_SellerAciti : UITableViewCell

@property (nonatomic, strong) UIImageView * headerImage;//头像
@property (nonatomic, strong) TQRichTextView * mainLabel;//标题
@property (nonatomic, strong) UILabel * detailLabel;//详情
@property (nonatomic, strong) UILabel * locationLabel;//100米
@property (nonatomic, strong) UILabel * joinLabel;//多少个人参与
@property (nonatomic, strong) UIImageView * mainView;//为了调整 cell之间的间距
@property (nonatomic, strong) UIImageView * positionIV;

@property (nonatomic, strong) UILabel * userLabel;//name
@property (nonatomic, strong) UIImageView * markImageView;//hot或者限时抢购
@end
