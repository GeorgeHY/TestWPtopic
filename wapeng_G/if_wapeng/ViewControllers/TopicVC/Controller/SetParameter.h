//
//  SetParameter.h
//  if_wapeng
//
//  Created by 早上好 on 14-10-8.
//  Copyright (c) 2014年 funeral. All rights reserved.
//这个类是把各种http请求的各种键值对提出来放在一起 为了vc代码整洁

#import <Foundation/Foundation.h>

@interface SetParameter : NSObject
@property(nonatomic , strong) NSString * D_ID;
@property(nonatomic , strong) NSString * _id;
//话题楼主键值对
+(NSDictionary *)setRequestParam;
//话题回复键值对
+(NSDictionary *)setRequestReplyParam:(NSString *)name;
//话题回复检索键值对
+(NSDictionary *)setRequestTalkReplyParam;
//话题 举报某个话题参数
+(NSDictionary *)setParamReportTopicID:(NSString *)topic_Id content:(NSString *)info;
//话题 举报某个话题回复参数
+(NSDictionary *)setParamReplyReportTopicID:(NSString *)topic_Id content:(NSString *)info;
//收藏某个话题或者话题回复的参数
+(NSDictionary *)setParamTopicStoreTopId:(NSString*)topic_Id topicReplyId:(NSString *)repleyId  topicStoreType:(NSString *)type actType:(NSString *)actType;


@end
