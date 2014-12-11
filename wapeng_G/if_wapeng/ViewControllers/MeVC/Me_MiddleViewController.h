//
//  Me_MiddleViewController.h
//  if_wapeng
//
//  Created by 永不死的圣斗士 on 14-6-18.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideBarSelectedDelegate.h"
@interface Me_MiddleViewController : UIViewController<UINavigationControllerDelegate,SideBarSelectDelegate>
{
    
}
@property (strong,nonatomic) UIView *contentView;
@property (strong,nonatomic) UIView *navBackView;

+(id)share;
@end
