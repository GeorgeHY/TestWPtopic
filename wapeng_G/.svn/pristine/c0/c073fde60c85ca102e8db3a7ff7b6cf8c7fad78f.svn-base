//
//  Confirm.h
//  if_wapeng
//
//  Created by 早上好 on 14-9-29.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

typedef void (^OnTouchBlock)(TouchEventType type);
#import <UIKit/UIKit.h>

@interface Confirm : UIView
@property(nonatomic , strong) UILabel * title;
@property(nonatomic , strong) UIButton * confirm;
@property(nonatomic , strong) UIButton * end;
@property(nonatomic , assign) TouchEventType touchType;
@property(nonatomic , copy) OnTouchBlock block;
-(void)showDialog;
@end
