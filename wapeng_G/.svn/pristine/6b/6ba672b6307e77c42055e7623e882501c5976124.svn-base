//
//  InterfaceLibrary.m
//  if_wapeng
//
//  Created by 心 猿 on 14-9-8.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "InterfaceLibrary.h"

#import "Item_AllWinwow.h"//橱窗全部

@implementation InterfaceLibrary

+(instancetype)shareInterfaceLibrary
{
    static InterfaceLibrary * lib;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        if (lib == nil) {
            lib = [[InterfaceLibrary alloc]init];
        }
    });
    return lib;
}
-(NSMutableArray *)interfaceOne
{
    arr_data = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 15; i++) {
        NSString * str = [NSString stringWithFormat:@"%d", i];
        
        [arr_data addObject:str];
    }
    return arr_data;
}
//活动详情
-(NSMutableArray *)interfaceAcitityDetail
{
    NSMutableArray * arr_one = [[NSMutableArray alloc]init];
    
    //两个section
    for (int i = 0; i < 2; i++) {
       NSMutableArray * arr_two = [[NSMutableArray alloc]init];
        if (i == 0) {
            
            NSString * utf8Str = [NSString stringWithFormat:@"习近平"];
            
            NSString *unicodeStr = [NSString stringWithCString:[utf8Str UTF8String] encoding:NSUnicodeStringEncoding];

            [arr_two addObject:unicodeStr];
            
            [arr_one addObject:arr_two];
        }
        if ( i == 1) {
            
            for (int i = 0; i < 15; i++) {
                NSString * str = [NSString stringWithFormat:@"hello, how are you fine and you? hello, how are you fine and you? hello, how are you fine and you? hello, how are you fine and you? hello, how are you fine and you?"];
    
                [arr_two addObject:str];
                
               
            }
             [arr_one addObject:arr_two];
        }
    }
    return arr_one;
}
//橱窗全部
-(NSMutableArray *)interfaceAllWinwow
{
    NSMutableArray * array_one = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 20; i++) {
        Item_AllWinwow * item = [[Item_AllWinwow alloc]init];
        item.nickName = [NSString stringWithFormat:@"小猪妈妈%d",i  ];
        item.time = @"20141111";
        item.age = [NSString stringWithFormat:@"%d", i];
        item.content = @"今天天气不错，挺风和日丽的，今天天气不错，挺风和日丽的今天天气不错，挺风和日丽的今天天气不错，挺风和日丽的今天天气不错，挺风和日丽的今天天气不错，挺风和日丽的今天天气不错，挺风和日丽的";
        item.remarkCount = [NSString stringWithFormat:@"评论：%d", i];
        item.isOpen = NO;
        [array_one addObject:item];
    }
    return array_one;
}
-(NSString *)interfaceLoginWithType:(int)type
{
    NSString * acctount = nil;
    NSString * pwd = nil;
    switch (type) {
        case 0:
        {
            NSLog(@"机构用户");
            acctount = @"10000000001";
            pwd = @"123";
            
        }
            break;
        case 1:
        {
            NSLog(@"家长用户");
            acctount = @"20000000001";
            pwd = @"123";
        }
            break;
        case 2:
        {
            NSLog(@"教师用户");
            acctount = @"30000000001";
            pwd = @"123";
        }
            break;
        case 3:
        {
            NSLog(@"教师用户");
            acctount = @"30000000002";
            pwd = @"123";
        }
            break;
        case 4:
        {
            NSLog(@"教师用户");
            acctount = @"30000000003";
            pwd = @"123";
        }
            break;
        default:
            break;
    }
    return acctount;
}
@end
