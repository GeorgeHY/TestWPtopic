//
//  Item_AllShowWindow.m
//  if_wapeng
//
//  Created by 心 猿 on 14-10-5.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "Item_AllShowWindow.h"

@implementation Item_AllShowWindow

-(id)init
{
    if (self = [super init]) {
        
        self.urlArray = [[NSMutableArray alloc]init];
    }
    return self;
}

-(CGFloat)heightWithWidth:(CGFloat)width Size:(int)size
{
    UIFont *font = [UIFont systemFontOfSize:size];
    NSDictionary *dict = @{NSFontAttributeName: font, NSForegroundColorAttributeName: [UIColor redColor]};
    CGRect rect = [self.content boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size.height;
}

@end
