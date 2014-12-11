//
//  Cell_WaterFlow.h
//  if_wapeng
//
//  Created by 心 猿 on 14-9-4.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
//瀑布流的cell
#import <UIKit/UIKit.h>

@interface Cell_WaterFlow : UITableViewCell
@property (nonatomic, strong) UIImageView * headerIView;//大图
@property (nonatomic, strong) UILabel * mainLabel;//内容
@property (nonatomic, strong) UILabel * titleLabel;//图片0,图片1
//........
@property (nonatomic, strong)UILabel * timeLabel;//时间的label
@property (nonatomic, strong) UIView * footerMainView;//底端工具条
@property (nonatomic, strong) UIView * headerView;//顶部工具条
@property (nonatomic, strong) UIImageView * goodIV;//点赞图标
//@property (nonatomic, strong) UILabel * remarkCountLbl;//评论数量
@property (nonatomic, strong) UILabel * remarkLabel;//评论
@property (nonatomic, strong) UILabel * goodCountLbl;
@property (nonatomic, strong) UILabel * postMsgLabel;//发帖人昵称
@property (nonatomic, strong) UIImageView * postMsgView;//发帖人的头像

@property (nonatomic, strong) UIView * centerView;//中间条
@property (nonatomic, strong) UIImageView * line;//分割线
@end
