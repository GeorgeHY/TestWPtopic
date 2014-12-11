//
//  Cell_Show.h
//  if_wapeng
//
//  Created by 心 猿 on 14-11-10.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TQRichTextView.h"

@interface Cell_Show : UITableViewCell

@property (nonatomic, strong) UILabel * nickNameLbl;//小武妈妈
@property (nonatomic, strong) UILabel * timeLbl;//8小时前
@property (nonatomic, strong) UIButton * deleteBtn;
@property (nonatomic, strong) TQRichTextView * contentLbl;//内容视图
@property (nonatomic, strong) UIButton * remarkBtn;//评论列表

@property (nonatomic, strong) UIImageView * showImageView;//需要展示的图片

@property (nonatomic, strong) UIImageView * headerImageView;//头像

@property (nonatomic, strong) UIButton * babyageBtn;//女孩， 2岁
@end
