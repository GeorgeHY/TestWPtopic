//
//  UIViewController+General.h
//  if_wapeng
//
//  Created by 心 猿 on 14-7-23.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"


@interface UIViewController (General)

-(void)navItemClick:(UIButton *)button;

-(void)initLeftItem;

-(void)buildSeperateline;

//初始化分割线
-(void)buildSeperatelineAndLiftItem;

//下拉刷新和上拉加载
- (void)setupRefresh:(UITableView *)newTableView;

-(void)headerRereshing;
-(void)footerRereshing;

-(void)createNavigation:(UIColor *)btnBgColor;
//-(void)leftButtonOnClick:(UIButton*)btn;
//-(void)rightButtonOnClick:(UIButton*)btn;

@end
