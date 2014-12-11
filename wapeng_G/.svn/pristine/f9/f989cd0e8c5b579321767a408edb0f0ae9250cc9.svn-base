//
//  MyTopicStoresTask.m
//  if_wapeng
//
//  Created by 早上好 on 14-10-24.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "MyTopicStoresTask.h"
#import "MyTopicStores.h"
#import "HotTopicEntity.h"
@implementation MyTopicStoresTask

+(void)requestData:(NSMutableDictionary *)dic setUrl:(NSString *)url owner:(MyTopicStores *)topicVC{
    NSMutableArray * dataSourceTopic = [[NSMutableArray alloc]  init];
    AFN_HttpBase * http = [[AFN_HttpBase alloc]  init];
    [http  sixReuqestUrl:url postDict:dic succeed:^(AFHTTPRequestOperation *operation, NSObject *obj, BOOL succeed) {
        NSDictionary * dic = (NSDictionary *)obj;
        NSMutableArray * array;
        NSDictionary * value = [dic objectForKey:@"value"];
        array = [value objectForKey:@"list"];
        for (int i = 0; i < 2 ; i++) {
            NSDictionary * d = [array  objectAtIndex:i];
            NSDictionary * topic = [d objectForKey:@"topic"];
            NSString * content = [topic objectForKey:@"content"];
            NSString * replies = [NSString stringWithFormat:@"%@",[topic objectForKey:@"replies"]];
            NSString * friendPartInCount = [NSString stringWithFormat:@"%@",[topic objectForKey:@"viewFriendPartInCount"]];
            NSString * title = [topic objectForKey:@"title"];
            NSString * _id = [topic objectForKey:@"id"];
            NSString * createTime = [topic objectForKey:@"createTime"];
            HotTopicEntity * hotTop = [[HotTopicEntity alloc] init];
            if ([@"<null>" isEqualToString:friendPartInCount]||[@"(null)" isEqualToString:friendPartInCount]) {
                friendPartInCount = @"0";
            }
            hotTop._id = _id;
            hotTop.reply = replies;
            hotTop.person =friendPartInCount;
            hotTop.content = content;
            hotTop.name = title;
            hotTop.createTime = createTime;
            [dataSourceTopic addObject:hotTop];
        }
        [topicVC setLoadData:dataSourceTopic];
    } failed:^(AFHTTPRequestOperation *operation, NSObject *obj, BOOL succeed) {
        
    }];

}
@end
