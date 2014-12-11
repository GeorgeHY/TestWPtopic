//
//  TimeTool.h
//  if_wapeng
//
//  Created by 早上好 on 14-9-25.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeTool : NSObject
+(NSString *)dateToString:(NSString *)time;
+(NSString *)getUTCFormateDate:(NSString *)newsDate;//计算多少天前

+(NSString *)timeStrTransverterSince1970Time:(NSString *)timeStr;
+(NSDate *)timeStrTransverterDate:(NSString *)timeStr;

/**活动模块计算宝宝年龄**/
+(NSMutableString *)getBabyAgeWithBirthday:(NSString *)brithday publicTime:(NSString *)publicTime;

+(BOOL)limitTime:(NSString *)limitTime;

/**发布活动 选择有效时间 15天， 计算15天后的日期**/

+(NSString *)getmyLimitTime:(NSString *)string;
/**获取当前时间戳**/
+(NSString *)since1970Time;
/**传入NSDate返回时间**/
+(NSString *)getTimeWithDate:(NSDate *)date;
@end
