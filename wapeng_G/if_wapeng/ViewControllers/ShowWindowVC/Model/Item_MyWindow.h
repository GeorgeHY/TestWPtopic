//
//  Item_MyWindow.h
//  if_wapeng
//
//  Created by 心 猿 on 14-9-27.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
///wpa/wb/mact/activityAction_getHeatList.action
//我的橱窗
#import <Foundation/Foundation.h>
@interface Item_MyWindow : NSObject
@property (nonatomic, assign) BOOL  isOpen;//section是否被展开
@property (nonatomic, strong) NSString * age;//孩子年龄
@property (nonatomic, assign) int gender;//孩子性别1男2女
@property (nonatomic, strong) NSString * time;//创建时间
@property (nonatomic, strong) NSString * petName;
@property (nonatomic, strong) NSString * wpCode;//娃朋号
@property (nonatomic, strong) NSString * content;//内容
@property (nonatomic, strong) NSString * photoUrl;
@property (nonatomic, strong) NSMutableArray * urlArray;
@property (nonatomic, strong) NSString * isButtom;//是否有下一页
@property (nonatomic, assign) NSInteger  replies;//回复数
@property (nonatomic, assign) NSInteger supports;//点赞书
@property (nonatomic, assign) int viewReportFlag; //是否举报
@property (nonatomic, assign) int viewSupportFlag;//是否点赞
@property (nonatomic, assign) BOOL hasPic;//是否有图片
@property (nonatomic, strong) NSString * momentID;//瞬间id
@property (nonatomic, strong) NSString * birthday;
@property (nonatomic, assign) int remakCount;//页码，用于点击加载更多

@property (nonatomic, strong) NSString * authorID;//作者id

@property (nonatomic, assign) int userType;//用户id类型 1.家长 2.教师 3.机构
-(CGFloat)heightWithWidth:(CGFloat)width Size:(int)size;
-(CGFloat)height;
@end
