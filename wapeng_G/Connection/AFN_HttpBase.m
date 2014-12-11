//
//  AFN_HttpBase.m
//  if_wapeng
//
//  Created by 心 猿 on 14-8-13.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "AFN_HttpBase.h"
#import "TimeTool.h"
@implementation AFN_HttpBase
-(NSDictionary *)asmmbleDic:(NSString *)firstObj, ...NS_REQUIRES_NIL_TERMINATION
{
    
    //盛放key的array
    NSMutableArray * keyArray = [NSMutableArray array];
    
    //盛放value的array
    NSMutableArray * valueArray = [NSMutableArray array];
    
    va_list arg_ptr;
    
    va_start(arg_ptr, firstObj);
    
    if (firstObj == nil) {
        
        return nil;
    }
    
    [keyArray addObject:firstObj];
    
    NSString * temp = nil;
    
    int i = 1;
    
    while ((temp = va_arg(arg_ptr, NSString *))) {//Bad_access
        
        //说明
        if (i % 2 == 1) {
            
            [valueArray addObject:temp];
            
        }else{
            
            [keyArray addObject:temp];
        }
        i++;
    }
    va_end(arg_ptr);
    
    if(i % 2 == 0)
    {
        NSLog(@"变长参数的个数是偶数");
    }else{
        NSLog(@"变长参数的个数是奇数");
        return  nil;
    }
    
    NSDictionary * dict = [[NSDictionary alloc]initWithObjects:valueArray forKeys:keyArray];
    
    return dict;
}

-(void)firstReuqestWithUrl:(NSString *)url postDict:(NSDictionary *)dict 
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSString * newUrl = [NSString stringWithFormat:@"%@%@",url, dAPP_URL_STR];
    [manager POST:newUrl parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.block(responseObject, YES);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败!");
        self.block(error, NO);
    }];
}

-(void)secondRequestWithUrl:(NSString *)url andKeyValuePairs:(NSString *)firstObj,...NS_REQUIRES_NIL_TERMINATION
{
    //盛放key的array
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
        [SVProgressHUD showSimpleText:@"传参有误"];
        return;
    }
    
    NSDictionary * dict = [[NSDictionary alloc]initWithObjects:valueArray forKeys:keyArray];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSString * newUrl = [NSString stringWithFormat:@"%@%@",url, dAPP_URL_STR];
    
    NSLog(@"requestUrl:%@", newUrl);
    
    [manager POST:newUrl parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.block(responseObject, YES);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        self.block(error, NO);
    }];
}



-(void)thirdRequestWithUrl:(NSString *)url succeed:(ReceiveDataBlock)succeed failed:(ReceiveDataBlock)failed andKeyValuePairs:(NSString *)firstObj,...NS_REQUIRES_NIL_TERMINATION
{
    //盛放key的array
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
    
    while ((temp = va_arg(arg_ptr, NSString *))) {//Bad_access
        
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
//        NSLog(@"变长参数的个数是偶数");
    }else{
        NSLog(@"变长参数的个数是奇数");
        NSLog(@"最后一个参数是%d", i);
        [SVProgressHUD showSimpleText:@"传参有误"];
        return;
    }
    
    NSDictionary * dict = [[NSDictionary alloc]initWithObjects:valueArray forKeys:keyArray];
    
    NSLog(@"{postDic}:%@", dict);
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSString * newUrl = [NSString stringWithFormat:@"%@%@",dAPP_URL_STR, url];
    NSLog(@"%@", newUrl);
    [manager POST:newUrl parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"***********************************************************");
        NSLog(@"请求地址:%@", newUrl);
        NSLog(@"请求成功，结果为:%@", responseObject);
       NSLog(@"***********************************************************");
        //指针指向block
        self.block = succeed;
        
        self.block(responseObject, YES);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"***********************************************************");
        NSLog(@"请求地址:%@", newUrl);
        NSLog(@"请求失败:%@", error);
        NSLog(@"***********************************************************");
        
        [SVProgressHUD showErrorWithStatus:dTips_requestError];
        
        self.block = failed;
        
        self.block(error, NO);
       
    }];
}

/**单张图片上传**/
-(void)sevenReuqestWithUrl:(NSString *)url postDict:(NSDictionary *)dcit image:(UIImage *)image successed:(ReceiveDataBlock)successed failed:(ReceiveDataBlock)failed
{
    
    NSString * newUrl = [dAPP_URL_STR stringByAppendingString:url];
    
    NSLog(@"***********************************************");
    
    NSLog(@"请求地址：%@", url);
    
    NSLog(@"***********************************************");

    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/html"];
    
    [manager POST:newUrl parameters:dcit constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
//        formData appendPartWithFileData:UIImagePNGRepresentation(image)name:@"Filedata"fileName:@"test.jpg"mimeType:@"image/jpg"];
        
        [formData appendPartWithFileData:UIImagePNGRepresentation(image) name:@"attachment.uploadFile" fileName:[TimeTool since1970Time] mimeType:@"image/jpg"];
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData * root = (NSData *)responseObject;
        
        NSDictionary * rootDict = [NSJSONSerialization JSONObjectWithData:root options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"rootDict:%@", rootDict);
        
        self.block = successed;
        self.block(rootDict, YES);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        self.block = failed;
        self.block(error, NO);
        
    }];
    
}

/**上传多张图片**/
-(void)fourRequestWithUrl:(NSString *)url postDict:(NSDictionary *)dict arrayImage:(NSArray *)arrayImage successed:(ReceiveDataBlock)successed failed:(ReceiveDataBlock)failed
{
    NSMutableURLRequest * request = [[AFHTTPRequestSerializer serializer]multipartFormRequestWithMethod:@"POST" URLString:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (int i = 0; i < [arrayImage count]; i++) {
            
            UIImage * uploadImage = arrayImage[i];
            
            [formData appendPartWithFileData:UIImagePNGRepresentation(uploadImage) name:nil fileName:[TimeTool since1970Time] mimeType:@"image/jpg"];
        }
        
    } error:nil];

    AFHTTPRequestOperation *opration = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    opration.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [opration setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
       
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
    }];
    
}
-(void)fiveReuqestUrl:(NSString *)url postDict:(NSDictionary *)dict succeed:(ReceiveDataBlock)succeed failed:(ReceiveDataBlock)failed
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString * newUrl = [NSString stringWithFormat:@"%@%@",dAPP_URL_STR,url];
    [manager POST:newUrl parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     
{
//    NSLog(@"测试测试：%@", operation.responseString);
    
        NSLog(@"########################################");
        NSLog(@"{请求字典:}%@", dict);
    NSLog(@"***********************************************************");
   
        NSLog(@"请求地址:%@", newUrl);
        NSLog(@"请求成功，结果为:%@", responseObject);
        NSLog(@"***********************************************************");
        
        self.block = succeed;
        self.block(responseObject, YES);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"########################################");
        NSLog(@"{请求字典:}%@", dict);
      
        NSLog(@"***********************************************************");
        NSLog(@"请求地址:%@", newUrl);
        NSLog(@"请求失败:%@", error);
        NSLog(@"***********************************************************");
        self.block = failed;
        self.block(error, NO);
    }];
}

//第六个请求方法 把block 里面加入了AFHTTPRequestOperation 可以随时切断网络连接
-(void)sixReuqestUrl:(NSString *)url postDict:(NSDictionary *)dict succeed:(ResponseDataBlock)succeed failed:(ResponseDataBlock)failed
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSString * newUrl = [NSString stringWithFormat:@"%@%@",dAPP_URL_STR,url];
    [manager POST:newUrl parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.responseBlock = succeed;
        self.responseBlock(operation,responseObject, YES);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败!");
        self.responseBlock = failed;
        self.responseBlock(operation,error, NO);
    }];
}

- (void)reach
{
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 局域网络,不花钱
     */
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        NSLog(@"%d", status);
    }];
}
@end
