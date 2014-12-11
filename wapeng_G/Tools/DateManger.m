//
//  DateManger.m
//  if_wapeng
//
//  Created by 心 猿 on 14-8-19.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "DateManger.h"

@implementation DateManger
-(NSString *) dateforGreenwich{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time =[date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}
@end
