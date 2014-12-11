//
//  MyMailTask.m
//  if_wapeng
//
//  Created by 早上好 on 14-10-27.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "MyMailTask.h"
#import "AFN_HttpBase.h"
#import "Item_MyMailEntity.h"
#import "MyMailVC.h"
@implementation MyMailTask



+(void) requsetFriendDataWithUrl:(NSString *)url setParam:(NSMutableDictionary*)param dataSource:(NSMutableArray *)dataSource viewController:(MyMailVC*)vc;
{
    AFN_HttpBase * http = [[AFN_HttpBase alloc]  init];
    [http sixReuqestUrl:url postDict:param succeed:^(AFHTTPRequestOperation *operation, NSObject *obj, BOOL succeed) {
        
        NSDictionary * root =  (NSDictionary *)obj;
        
        NSArray * list = [[root objectForKey:@"value"] objectForKey:@"list"];
        
        for (NSDictionary * dict in list) {
            
            Item_MyMailEntity * item = [[Item_MyMailEntity alloc]init];
            item.isButtom = [[[root objectForKey:@"value"] objectForKey:@"isButtom"] intValue];
            
            NSLog(@"%d", item.isButtom);
            
            NSArray * letterList = [dict objectForKey:@"letterList"];
            NSDictionary * newDict = [letterList lastObject];
            item.content = [newDict objectForKey:@"content"];
            item.createTime = [newDict objectForKey:@"createTime"];
            item.read = [[dict objectForKey:@"read"]intValue];
            item.petName = kNullData;
            if (isNotNull([[dict objectForKey:@"sender"] objectForKey:@"petName"])) {
                item.petName = [[dict objectForKey:@"sender"] objectForKey:@"petName"];
            }
            
            
            item.relativePath = @"";
            if (isNotNull([dict objectForKey:@"photo"])) {
                if (isNotNull([[dict objectForKey:@"photo"] objectForKey:@"relativePath"])) {
                      item.relativePath = [[dict objectForKey:@"photo"] objectForKey:@"relativePath"];
                }
            }
            
            [dataSource addObject:item];
        }

//        [vc.tableView reloadData];
//        [vc.tableView headerEndRefreshing];
//        [vc.tableView footerEndRefreshing];
    } failed:^(AFHTTPRequestOperation *operation, NSObject *obj, BOOL succeed) {
        
    }];
    http = nil;
}

@end
