//
//  SetParameter.m
//  if_wapeng
//
//  Created by 早上好 on 14-10-8.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "SetParameter.h"

@implementation SetParameter

static SetParameter* setParam = nil;
+(SetParameter *) sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        setParam = [[SetParameter alloc]  init];
    });
    return  setParam;
}
//话题楼主键值对
+(NSDictionary *)setRequestParam:(NSString *)topid
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc]  init];
    [param setValue:setParam._id forKey:@"topicQuery.id"];
    [param setValue:setParam.D_ID forKey:@"D_ID"];
    return param;
}

//话题回复键值对
+(NSDictionary *)setRequestReplyParam:(NSString *)name
                            optionBtn:(UIButton*)btn
                           importText:(UITextField *)importText
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc]  init];
    [param setValue:setParam.D_ID forKey:@"D_ID"];
    [param  setValue:setParam._id forKey:@"topicReply.topic.id"];
    NSString * flag = btn.selected == YES?@"1":@"2";
    [param setValue:flag forKey:@"topicReply.anonymousFlag"];
    NSString * content;
    NSString * textContent = importText.text;
    if (name.length <= 0||nil == name) {
        content = textContent;
    }else{
        content = [NSString stringWithFormat:@"%@%@",name , textContent];
    }
    [param setValue:content forKey:@"topicReply.content"];
    return param;
}
//话题回复检索键值对
/*
+(NSDictionary *)setRequestTalkReplyParam
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc]  init];
    [param setValue:setParam._id forKey:@"topicReplyQuery.topicID"];
    [param setValue:setParam.D_ID forKey:@"D_ID"];
    [param setValue:@"1" forKey:@"topicReplyQuery.pageNum"];
    switch (trqType) {
        case TopicHot://热度
            [param setValue:@"1" forKey:@"topicReplyQuery.sort"];
            break;
        case TopicTime://时间
            [param setValue:@"2" forKey:@"topicReplyQuery.sort"];
            break;
        case TopicRelation://关系
            [param setValue:@"3" forKey:@"topicReplyQuery.sort"];
            break;
        default:
            break;
    }
    return param;
}
//话题 举报某个话题参数
+(NSDictionary *)setParamReportTopicID:(NSString *)topic_Id content:(NSString *)info
{

}
//话题 举报某个话题回复参数
+(NSDictionary *)setParamReplyReportTopicID:(NSString *)topic_Id content:(NSString *)info
{

}
//收藏某个话题或者话题回复的参数
+(NSDictionary *)setParamTopicStoreTopId:(NSString*)topic_Id topicReplyId:(NSString *)repleyId  topicStoreType:(NSString *)type actType:(NSString *)actType
{

}
*/
@end
