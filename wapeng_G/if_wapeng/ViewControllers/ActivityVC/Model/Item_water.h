//
//  Item_water.h
//  if_wapeng
//
//  Created by 心 猿 on 14-9-4.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item_water : NSObject

//@property (nonatomic, strong) NSString * imageUrl;
//@property (nonatomic, strong) NSString * text;

@property (nonatomic, strong) UIImage * photo;//因为是瀑布流，所以先下载图片确定size
//photoURL
@property (nonatomic, strong) NSString * content;//内容
@property (nonatomic, strong) NSString * createTime;//创建时间
@property (nonatomic, strong) NSString * limitTime;//截止时间
@property (nonatomic, strong) NSString * title;//标题
@property (nonatomic, strong) NSString * replies;//回复数
@property (nonatomic, strong) NSString * supports;//点赞数
@property (nonatomic, strong) NSString * imageUrl;//头像
@property (nonatomic, strong) NSString * petName;// 昵称
//晚睡姐姐 晚睡姐姐头像 赞数目 评论数目
@property (nonatomic, strong) NSString * actId;
-(CGFloat)height;
-(CGFloat)heightImage;//返回瀑布流的高度
-(NSString *)getUTCFormateDate:(NSString *)newsDate;
@end
