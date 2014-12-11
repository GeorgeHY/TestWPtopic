//
//  ASIHttpTool.m
//  MealOrder
//
//  Created by 心 猿 on 14-9-6.
//  Copyright (c) 2014年 Iwind. All rights reserved.
//

#import "ASIHttpTool.h"

@implementation ASIHttpTool

-(id)init
{
    if (self = [super init]) {
    }
    return self;
}
/*
 url的格式比如 usename/dajuejinxian/pwd/123456
 */
-(void)get:(RequestFinished)block url:(NSString *)url pairs:(NSString *)firstObj, ...NS_REQUIRES_NIL_TERMINATION
{
    //先组装字符串
    va_list ptr;
    va_start(ptr, firstObj);
    
    int i = 0;
    NSMutableString * ret = [[NSMutableString alloc]initWithCapacity:0];
    //先安装第一个key
    [ret appendString:firstObj];
    while (1) {
       NSMutableString * temp =  va_arg(ptr, NSMutableString *);
        if (!temp) {
            break;
        }
        if (i % 1 == 0) {
            //安装value
            [ret appendFormat:@"/%@", temp];
        }else{
            [ret appendFormat:@"%@", temp];
        }
        i++;
    }
//组装后的字符串
    NSLog(@"%@", ret);
    NSString * base = dAPP_URL_STR;
    
    //拿到最后一个字符
    NSString * last = [dAPP_URL_STR substringFromIndex:dAPP_URL_STR.length - 1];
    if([last isEqualToString:@"/"])
    {
        base = [base substringToIndex:base.length - 1];
    }
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    base = [base stringByAppendingFormat:@"%@/", url];
    
    ret = [NSMutableString stringWithFormat:@"%@/%@",base, ret];
    NSLog(@"-----------------------------------------------");
    NSLog(@"Get请求地址:%@",ret);
    NSLog(@"-----------------------------------------------");
    __block ASIHttpTool * weakSelf = self;
    _request_get = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:ret]];
    [_request_get setCompletionBlock:^{
       //回调成功,因为数据格式不固定，所以就不在此处解析
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:weakSelf.request_get.responseData options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"请求结果:%@", dict);
        
        block(dict, YES);
    }];
    [_request_get setFailedBlock:^{
        NSLog(@"Get请求失败");
        block(nil, NO);
    }];
    [self.request_post startAsynchronous];
}
-(void)get:(RequestFinished)block url:(NSString *)url
{
//    [self get:block url:url pairs: nil];
}
-(void)postWithUrl:(NSString *)url postArray:(NSDictionary *)postDict block:(RequestFinished)block
{
    NSString * base = dAPP_URL_STR;
    NSString * last = [dAPP_URL_STR substringFromIndex:dAPP_URL_STR.length - 1];
    if([last isEqualToString:@"/"])
    {
        base = [base substringToIndex:dAPP_URL_STR.length - 1];
    }
    
     url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString * requstUrl = [NSString stringWithFormat:@"%@/%@",base, url];
    NSLog(@"-----------------------------------------------");
    NSLog(@"Post请求地址:%@",requstUrl);
    NSLog(@"-----------------------------------------------");
    self.request_post = [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:requstUrl]];
    
    [self.request_post setRequestMethod:@"POST"];
    
    NSEnumerator * keys= [postDict keyEnumerator];
    
    for (NSObject * obj in keys) {
        
        NSString * key = [NSString stringWithFormat:@"%@", obj];
        
        [self.request_post setPostValue:[postDict objectForKey:key] forKey:key];
    }
    
    __block ASIHttpTool * weakSelf = self;
    
    [self.request_post setCompletionBlock:^{
        
        [NSString stringWithFormat:@"测试数据：%@", self.request_post.responseString];
        NSLog(@"%@", self.request_post.responseData);
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:self.request_post.responseData options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"post请求成功");
        NSLog(@"请求结果%@", dict);
//        block(dict, YES);
    }];
    
    [self.request_post setFailedBlock:^{
        NSLog(@"post请求失败");
        block(nil, NO);
       
    }];
    [self.request_post startAsynchronous];
}
-(void)post:(RequestFinished)block url:(NSString *)url pairs:(NSString *)firstObj, ...NS_REQUIRES_NIL_TERMINATION
{
    NSMutableArray * keyArray = [NSMutableArray array];
    
    //盛放value的array
    NSMutableArray * valueArray = [NSMutableArray array];
    
    va_list arg_ptr;
    
    va_start(arg_ptr, firstObj);
    
    if (firstObj == nil) {
        
        return;
    }
    
    [keyArray addObject:firstObj];
    
    NSString * temp = nil;
    
    int i = 1;
    
    while ((temp = va_arg(arg_ptr, NSString *))) {
        
        //说明
        if (i % 2 == 1) {
            
            [valueArray addObject:temp];
            
        }else{
            
            [keyArray addObject:temp];
        }
        i++;
    }
    va_end(arg_ptr);
    
    //判读输入的变长参数个数是否合法
    if(i % 2 == 0)
    {
        NSLog(@"变长参数的个数是偶数");
    }else{
        NSLog(@"变长参数的个数是奇数");
        NSLog(@"传入参数错误");
        return;
    }
    //这里的地址是服务器的基地址，也可由参数传入
    NSString * base = dAPP_URL_STR;
    NSString * last = [dAPP_URL_STR substringFromIndex:dAPP_URL_STR.length - 1];
    if([last isEqualToString:@"/"])
    {
        base = [base substringToIndex:dAPP_URL_STR.length - 1];
    }
    
     url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString * requstUrl = [NSString stringWithFormat:@"%@/%@",base, url];
    NSLog(@"-----------------------------------------------");
    NSLog(@"Post请求地址:%@",requstUrl);
    NSLog(@"-----------------------------------------------");

    self.request_post = [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:requstUrl]];
    
    [self.request_post setRequestMethod:@"POST"];
    
    for(int i = 0; i < keyArray.count; i++)
    {
//        [self.request_post setValue:[valueArray objectAtIndex:i] forKey:[NSString stringWithFormat:@"%@", [keyArray objectAtIndex:i]]];
        [self.request_post setPostValue:valueArray[i] forKey:[NSString stringWithFormat:@"%@", keyArray[i]]];
    }
    
    __block ASIHttpTool * weakSelf = self;
    
    [self.request_post setCompletionBlock:^{
        NSLog(@"post请求成功");
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:weakSelf.request_post.responseData options:NSJSONReadingMutableContainers error:nil];
        block(dict, YES);
    }];
    [self.request_post setFailedBlock:^{
         NSLog(@"post请求失败");
        block(nil, NO);
    }];
    [self.request_post startAsynchronous];
}
+(instancetype)tool
{
    return [[[self class] alloc] init];
}
@end
