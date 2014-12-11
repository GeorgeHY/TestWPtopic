//
//  Item_water.m
//  if_wapeng
//
//  Created by 心 猿 on 14-9-4.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "Item_water.h"

@implementation Item_water
//暂时只计算label的高度
-(CGFloat)height
{
    UIFont *font = [UIFont systemFontOfSize:12];
    NSDictionary *dict = @{NSFontAttributeName: font, NSForegroundColorAttributeName: [UIColor redColor]};
    CGRect rect = [self.content boundingRectWithSize:CGSizeMake(kMainScreenWidth / 2 - 20, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    //加上图片的高度
    return rect.size.height;
}
//返回瀑布流图片的高度
-(CGFloat)heightImage
{
    return self.photo.size.height;
}

-(NSString *)getUTCFormateDate:(NSString *)newsDate
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

@end
