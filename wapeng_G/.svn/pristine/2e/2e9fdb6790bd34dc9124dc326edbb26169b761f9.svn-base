//
//  MsgItem.h
//  if_wapeng
//
//  Created by 心 猿 on 14-11-19.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
typedef enum {
    MessageTypeMe = 0, // 我发的
    MessageTypeOther = 1 // 别人发的
} MessageType;
#import <Foundation/Foundation.h>

@interface MsgItem : NSObject

@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * icon;
@property (nonatomic, strong) NSString * time;
@property (nonatomic, assign) MessageType type; // 消息类型

- (id)initWithDict:(NSDictionary *)dict;
+ (id)messageWithDict:(NSDictionary *)dict;

@end
