//
//  Item_AllShowWindow.h
//  if_wapeng
//
//  Created by 心 猿 on 14-10-5.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item_AllShowWindow : NSObject
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, strong) NSString * age;//宝宝年龄
@property (nonatomic, strong) NSString * createTime;//创建时间
@property (nonatomic, strong) NSString * petName;//昵称
@property (nonatomic, strong) NSString * photoURL;//头像
@property (nonatomic, strong) NSString * content;//内容
@property (nonatomic, strong) NSString * gender;//性别
@property (nonatomic, strong) NSMutableArray * urlArray;
-(CGFloat)heightWithWidth:(CGFloat)width Size:(int)size;
@end
