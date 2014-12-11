//
//  AFN_HttpBase.h
//  if_wapeng
//
//  Created by 心 猿 on 14-8-13.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"


typedef void (^ReceiveDataBlock) (NSObject * obj, BOOL isFinished);
typedef void (^ResponseDataBlock) (AFHTTPRequestOperation * operation , NSObject * obj , BOOL succeed);


@interface AFN_HttpBase : NSObject

#pragma mark - 组装post请求字典

-(NSDictionary *)asmmbleDic:(NSString *)firstObj, ...NS_REQUIRES_NIL_TERMINATION;

-(void)firstReuqestWithUrl:(NSString *)url postDict:(NSDictionary *)dict;
-(void)secondRequestWithUrl:(NSString *)url andKeyValuePairs:(NSString *)firstObj,...NS_REQUIRES_NIL_TERMINATION;

#pragma mark - 第三请求方法，在一次行性求中方·便使用

-(void)thirdRequestWithUrl:(NSString *)url succeed:(ReceiveDataBlock)succeed failed:(ReceiveDataBlock)failed andKeyValuePairs:(NSString *)firstObj,...NS_REQUIRES_NIL_TERMINATION;

#pragma mark - 第五请求方法，使用最多的方法，在tableView中使用比较多
/**
 para1 url：相对地址
 para2 postDict：post请求字典
FocusVC 中有具体用法
 **/
-(void)fiveReuqestUrl:(NSString *)url postDict:(NSDictionary *)dict succeed:(ReceiveDataBlock)succeed failed:(ReceiveDataBlock)failed;
-(void)sixReuqestUrl:(NSString *)url postDict:(NSDictionary *)dict succeed:(ResponseDataBlock)succeed failed:(ResponseDataBlock)failed;

#pragma mark - 上传单张图片的方法，此项目中所有图片都是一张一张的上传
/**上传单张图片**/
-(void)sevenReuqestWithUrl:(NSString *)url postDict:(NSDictionary *)dcit image:(UIImage *)image successed:(ReceiveDataBlock)successed failed:(ReceiveDataBlock)failed;
@property (nonatomic, copy) ReceiveDataBlock block;
@property (nonatomic, copy) ResponseDataBlock responseBlock;
@end
