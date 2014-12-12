//
//  HotTopicEntity.h
//  if_wapeng
//
//  Created by 心 猿 on 14-8-7.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotTopicEntity : NSObject
@property(nonatomic , retain) NSString * _id;
@property(nonatomic , retain) NSString * top;
@property(nonatomic , retain) NSString * reply;
@property(nonatomic , retain) NSString*  person;
@property(nonatomic , retain) NSString*  content;
@property(nonatomic , retain) NSString * head;
@property(nonatomic , retain) NSString * name;
@property(nonatomic , retain) NSString * createTime;
@property(nonatomic , retain) NSString * userPhotoUrl;
@property (nonatomic, assign) int isButtom;//是否有下一页
@end
