//
//  FinderPasswordVC.h
//  if_wapeng
//
//  Created by 心 猿 on 14-7-28.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinderPasswordVC : UIViewController

@property (nonatomic, strong) NSString * msgID;//验证码id
@property (nonatomic, strong) NSString * phoneNum;//手机号

@property (nonatomic, strong) NSString * code;//生成的文字
@property (nonatomic, strong) UILabel * checkCodeNumberLabel;
@end
