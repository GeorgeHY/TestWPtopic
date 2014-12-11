//
//  OtherPersonHeaderView.m
//  if_wapeng
//
//  Created by 心 猿 on 14-11-18.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "OtherPersonHeaderView.h"

@implementation OtherPersonHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
+(instancetype)instanceView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"OtherPersonHeaderView" owner:nil options:nil]lastObject];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
