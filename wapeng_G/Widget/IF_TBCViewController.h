//
//  IF_TBCViewController.h
//  if_wapeng
//
//  Created by 永不死的圣斗士 on 14-6-17.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IF_TBCViewController : UITabBarController<UITabBarControllerDelegate>

@property (nonatomic, strong) UIView * mainView;
@property (nonatomic, strong)  NSMutableArray * butArray;

-(void)reloadTBCWithController:(UIViewController *)vc;

-(void)setLeftVC:(NSInteger)type;

-(void)setItemWithIndexBg:(int)index;
@end
