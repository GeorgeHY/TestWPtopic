//
//  Item_RemarkList.m
//  if_wapeng
//
//  Created by 心 猿 on 14-10-21.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "Item_RemarkList.h"

@implementation Item_RemarkList

-(NSString *)htmlString:(NSString *)aString andBString:(NSString *)bString
{
    NSString * str1 = [NSString stringWithFormat:@"<font size = 15 color = '#0000ff'>%@:</font>", aString];
     NSString * str2 = [NSString stringWithFormat:@"<font size = 15 color = '#000000'>%@</font>", bString];
    
    NSString * str3 = [str1 stringByAppendingString:str2];
    return str3;
}

-(CGFloat)height
{
    NSString * ass = [NSString stringWithFormat:@"%@:%@", self.petName, self.content];
    CGSize size = [ass boundingRectWithSize:CGSizeMake(kMainScreenWidth - 80, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size;
    return size.height;
}
@end
