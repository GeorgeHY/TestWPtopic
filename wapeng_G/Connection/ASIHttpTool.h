//
//  ASIHttpTool.h
//  MealOrder
//
//  Created by 心 猿 on 14-9-6.
//  Copyright (c) 2014年 Iwind. All rights reserved.
//
/*

 */
typedef void (^RequestFinished) (NSDictionary * dict,BOOL isSuccessed);
#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
@interface ASIHttpTool : NSObject

@property (nonatomic, strong) ASIHTTPRequest * request_get;
@property (nonatomic, strong) ASIFormDataRequest * request_post;
@property (nonatomic, copy) RequestFinished finishedBlock;


+(instancetype)tool;
//get请求
-(void)get:(RequestFinished)block url:(NSString *)url pairs:(NSString *)firstObj, ...NS_REQUIRES_NIL_TERMINATION;
//get请求2
-(void)get:(RequestFinished)block url:(NSString *)url;
//post请求
-(void)post:(RequestFinished)block url:(NSString *)url pairs:(NSString *)firstObj, ...NS_REQUIRES_NIL_TERMINATION;
//post请求2
-(void)postWithUrl:(NSString *)url postArray:(NSDictionary *)postDict block:(RequestFinished)block;
@end
