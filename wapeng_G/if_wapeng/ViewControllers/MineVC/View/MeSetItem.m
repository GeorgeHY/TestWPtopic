//
//  MeSetItem.m
//  if_wapeng
//
//  Created by 符杰 on 14-10-15.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "MeSetItem.h"

@implementation MeSetItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(contentRect.size.width * 0.9, 0, 10, contentRect.size.height);
}

@end
