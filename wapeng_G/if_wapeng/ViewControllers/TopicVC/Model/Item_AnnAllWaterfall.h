//
//  Item_AnnAllWaterfalll.h
//  if_wapeng
//
//  Created by 早上好 on 14-9-8.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item_AnnAllWaterfall : NSObject
@property(nonatomic , strong) NSString * title;
@property(nonatomic , strong) NSString * time;
@property(nonatomic , strong) NSString * imageParh;
@property(nonatomic , strong) NSString * content;
//@property(nonatomic , strong) NSString * count;


@property(nonatomic , strong) NSString * heartCount;
@property(nonatomic , strong) NSString * msgCount;




-(CGFloat) lableHight;

@end
