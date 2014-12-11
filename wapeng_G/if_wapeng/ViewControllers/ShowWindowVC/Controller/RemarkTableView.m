//
//  RemarkTableView.m
//  if_wapeng
//
//  Created by 心 猿 on 14-9-15.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "RemarkTableView.h"

@implementation RemarkTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createTableView];
    }
    return self;
}

-(void)createTableView
{
    self.delegate = self;
    self.dataSource = self;
}

@end
