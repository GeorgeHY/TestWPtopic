//
//  Item_AnnAllWaterfalll.m
//  if_wapeng
//
//  Created by 早上好 on 14-9-8.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "Item_AnnAllWaterfall.h"

@implementation Item_AnnAllWaterfall

-(CGFloat) lableHight
{
    NSString * txt = self.content;
    UIFont *font = [UIFont systemFontOfSize:12];
    NSDictionary *dict = @{NSFontAttributeName: font, NSForegroundColorAttributeName: [UIColor redColor]};
    CGRect rect = [txt boundingRectWithSize:CGSizeMake(100, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size.height;
}
@end
