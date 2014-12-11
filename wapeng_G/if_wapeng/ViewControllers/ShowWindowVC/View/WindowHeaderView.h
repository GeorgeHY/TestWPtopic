//
//  WindowHeaderView.h
//  if_wapeng
//
//  Created by 心 猿 on 14-11-12.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WindowHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *headerIV;//头像
@property (weak, nonatomic) IBOutlet UILabel *nickLbl;//昵称
@property (weak, nonatomic) IBOutlet UIButton *gender;
@property (weak, nonatomic) IBOutlet UILabel *emotionLbl;//个性签名
@property (weak, nonatomic) IBOutlet UILabel *ageLbl;//年龄
@property (weak, nonatomic) IBOutlet UILabel *locationLbl;//位置
@property (weak, nonatomic) IBOutlet UILabel *wpCodeLbl;//娃朋号
@property (weak, nonatomic) IBOutlet UILabel *momentCountLbl;//瞬间数
@property (weak, nonatomic) IBOutlet UILabel *focusCountLbl;//关注数
@property (weak, nonatomic) IBOutlet UILabel *fansLbl;//粉丝数

@property (weak, nonatomic) IBOutlet UIButton *GoFocusBtn;

@property (weak, nonatomic) IBOutlet UIButton *GoFansBtn;

@property (weak, nonatomic) IBOutlet UIButton *momentBtn;

+(instancetype)instanceView;
@end
