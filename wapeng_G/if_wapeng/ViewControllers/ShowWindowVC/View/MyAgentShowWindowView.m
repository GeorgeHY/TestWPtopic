//
//  MyAgentShowWindowView.m
//  if_wapeng
//
//  Created by 心 猿 on 14-11-18.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "MyAgentShowWindowView.h"

@implementation MyAgentShowWindowView

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
    return [[[NSBundle mainBundle] loadNibNamed:@"MyAgentShowWindowView" owner:nil options:nil]lastObject];
}

@end
