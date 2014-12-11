//
//  Item_foucs.h
//  if_wapeng
//
//  Created by 心 猿 on 14-11-13.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item_foucs : NSObject

@property (nonatomic, strong) NSString * petName;//昵称
@property (nonatomic, strong) NSString * mid;//用户id
@property (nonatomic, strong) NSString * relativePath;
@property (nonatomic, assign) BOOL isHidden;//是否隐藏宝宝信息
@property (nonatomic, assign) int userType;//用户类型1.家长 2.幼师 3.其他
@property (nonatomic, strong) NSString * loaction;//地理位置信息
@property (nonatomic, strong) NSString * viewAttentionCount;//熟人关注数
@property (nonatomic, assign) int gender;//性别
@property (nonatomic, strong) NSString * createTime;//创建时间
@property (nonatomic, strong) NSString * birthday;//出生日期，用来计算宝宝年龄
@property (nonatomic, strong) NSString * age;
@end
