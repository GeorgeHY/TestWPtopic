//
//  ChageCityItem.h
//  if_wapeng
//
//  Created by 心 猿 on 14-8-20.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
//换个城市
#import <Foundation/Foundation.h>

@interface ChageCityItem : NSObject
@property (nonatomic, strong) NSString * childList;
@property (nonatomic, strong) NSString * code;
@property (nonatomic, strong) NSString * displaySeq;
@property (nonatomic, strong) NSString * mid;//城市1级别 id
@property (nonatomic, strong) NSString * sid;//城市2级别 id
@property (nonatomic, strong) NSString * latitude;
@property (nonatomic, strong) NSString * longitude;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * parent;
@property (nonatomic, strong) NSString * level;
@end
