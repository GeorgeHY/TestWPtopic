//
//  AgeTalkView.h
//  if_wapeng
//
//  Created by 早上好 on 14-9-10.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
typedef void (^OptionAgeBlock)(NSInteger index);
#import <UIKit/UIKit.h>

@interface AgeTalkView : UIView
-(void) createComponent;
@property(nonatomic , copy) OptionAgeBlock block;
@end
