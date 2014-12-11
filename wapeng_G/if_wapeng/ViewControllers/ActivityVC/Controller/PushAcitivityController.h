//
//  PushAcitivityController.h
//  if_wapeng
//
//  Created by FJie on 14-9-24.
//  Copyright (c) 2014年 funeral. All rights reserved.
//  活动发布

#import <UIKit/UIKit.h>
@class FastTextView;

@interface PushAcitivityController : UIViewController
{
    AFN_HttpBase * http;

}
@property(nonatomic,strong) FastTextView *fastTextView;

@property (nonatomic, strong) NSString * limitTime;
@property (nonatomic, strong) NSMutableArray * imageIDArr;

@property (nonatomic, assign) int type; // type == 1, 是话题发布, 2是活动发布
@end
