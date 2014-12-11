//
//  TimeTool.m
//  if_wapeng
//
//  Created by 早上好 on 14-9-25.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "TimeTool.h"

@implementation TimeTool
//时间戳转换字符串
+(NSString *)dateToString:(NSString *)time
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"]; //
    NSTimeInterval timeInterval = [time doubleValue];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}
/**获取当前时间字符串**/
+(NSString *)nowTimeStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"]; //
    NSDate *datenow = [NSDate date];
    return [formatter stringFromDate:datenow];
}
//获取当前时间戳
+(NSString *)since1970Time{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time =[dat timeIntervalSince1970]*1000;
    return [NSString stringWithFormat:@"%f", time];
}

/**活动模块计算宝宝年龄**/
+(NSMutableString *)getBabyAgeWithBirthday:(NSString *)brithday publicTime:(NSString *)publicTime
{
    
    NSDateComponents * com1 = [[self class] timeConmponet:publicTime];
    
    NSInteger year1 = [com1 year];
    NSInteger month1 = [com1 month]; // 1
    NSInteger day1 = [com1 day];
    
    NSDateComponents * com2 = [[self class] timeConmponet:brithday];
    
    NSInteger year2 = [com2 year];
    NSInteger month2 = [com2 month];//12
    NSInteger day2 = [com2 day];
    
    NSInteger daltaYear = year1 - year2;
    
    NSMutableString * str = [[NSMutableString alloc]init];
    //宝宝大于一岁
    if (daltaYear > 0) {
        
        if(month1 > month2)
        {
            [str appendFormat:@"%ld岁", daltaYear];
            return str;
        }else if (month1 < month2)
        {
            [str appendFormat:@"%ld岁", daltaYear - 1];
            return str;
        }else{
            
            if (day1 < day2 ) {
                
                [str appendFormat:@"%ld岁", daltaYear - 1];
                return str;
            }else if (day1 > day2)
            {
                [str appendFormat:@"%ld岁", daltaYear];
                return str;
            }else{
                [str appendFormat:@"%ld岁", daltaYear];
                return str;
            }
        }
    }else{

        NSInteger daltaMonth = month1 - month2;
        
        if (daltaMonth > 1) {
            
            NSInteger daltaDay = day1 - day2;
            
            if (daltaDay >= 0) {
                
//                NSLog(@"大于一个月");
                [str appendFormat:@"%ld个月", daltaMonth];
               return  str;
            }else{
                [str appendFormat:@"%ld天",  daltaDay];
              return str;
            }
        }else{
            NSInteger daltaDay = day1 - day2;
            [str appendFormat:@"%ld天", daltaDay];
            return str;
        }
        
    }
}


+(NSDateComponents *)timeConmponet:(NSString *)time
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *newsDateFormatted = [dateFormatter dateFromString:time];
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit|NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dd = [cal components:unitFlags fromDate:newsDateFormatted];
    //    /    int year = [dd year];
    //
    //    NSLog(@"year:%d", year);
    //    NSLog(@"dd:%@", dd);
    //    int week = [dd weekday];
    //    NSLog(@"weak:%d", week);
    //    int hour = [dd hour];
    //    int minute = [dd minute];
    //    int second = [dd second];
    return dd;
}
+(NSString *)getUTCFormateDate:(NSString *)newsDate
{
    //    newsDate = @"2013-08-09 17:01";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSLog(@"newsDate = %@",newsDate);
    NSDate *newsDateFormatted = [dateFormatter dateFromString:newsDate];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    
    NSDate* current_date = [[NSDate alloc] init];
    
    NSTimeInterval time=[current_date timeIntervalSinceDate:newsDateFormatted];//间隔的秒数
    int month=((int)time)/(3600*24*30);
    int days=((int)time)/(3600*24);
    int hours=((int)time)%(3600*24)/3600;
    int minute=((int)time)%(3600*24)/60;
    //    NSLog(@"time=%d",(double)time);
    
    NSString *dateContent;
    
    if(month!=0){
        
        dateContent = [NSString stringWithFormat:@"%@%i%@",@"   ",month,@"个月前"];
        
    }else if(days!=0){
        
        dateContent = [NSString stringWithFormat:@"%@%i%@",@"   ",days,@"天前"];
    }else if(hours!=0){
        
        dateContent = [NSString stringWithFormat:@"%@%i%@",@"   ",hours,@"小时前"];
    }else {
        
        dateContent = [NSString stringWithFormat:@"%@%i%@",@"   ",minute,@"分钟前"];
    }
    return dateContent;
}
//字符串格式 转换成 时间戳字符串
+(NSString *)timeStrTransverterSince1970Time:(NSString *)timeStr
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSDate* date = [formatter dateFromString:timeStr];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    return timeSp;
}
//字符串格式 转换成 date
+(NSDate *)timeStrTransverterDate:(NSString *)timeStr
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSDate* date = [formatter dateFromString:timeStr];
    return date;
}
+(BOOL)limitTime:(NSString *)limitTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate* date = [formatter dateFromString:limitTime];
    NSTimeInterval  limTmier = [date timeIntervalSince1970];
    
    NSTimeInterval  curTimer = [[NSDate date] timeIntervalSince1970];
    
    double t = curTimer - limTmier;

    if (t > 0) {
        
        return NO;
    }
    
    return YES;
    
}
/**发布活动 选择有效时间 15天， 计算15天后的日期**/
+(NSString *)getmyLimitTime:(NSString *)string
{
    int days =string.intValue;
    
     NSTimeInterval  curTime = [[NSDate date] timeIntervalSince1970];
    
    NSTimeInterval  furtureTime = days * 24 * 60 * 60;
    
    furtureTime += curTime;
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:furtureTime];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    return [formatter stringFromDate:confromTimesp];
}
/**传入NSDate返回时间**/
+(NSString *)getTimeWithDate:(NSDate *)date
{
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
   
    NSString * dateFormat = @"YYYY-MM-dd";
    [dateFormatter  setDateFormat:dateFormat];
    
    NSString * dateS =  [dateFormatter stringFromDate:date];
    
    return dateS;
}
@end
