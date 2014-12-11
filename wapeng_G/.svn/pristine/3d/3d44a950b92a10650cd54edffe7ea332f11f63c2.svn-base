//
//  MsgItem.m
//  if_wapeng
//
//  Created by 心 猿 on 14-11-19.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "MsgItem.h"

@implementation MsgItem


+ (id)messageWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

// self只能放在构造方法中赋值（构造方法必须以init开头，并且init后面的单词首字母必须大写）
- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.icon = dict[@"icon"];
        self.content = dict[@"content"];
        self.time = dict[@"time"];
        self.type = [dict[@"type"] intValue];
    }
    return self;
}
@end
