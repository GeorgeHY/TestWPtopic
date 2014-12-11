//
//  WaterFlowVC.h
//  if_wapeng
//
//  Created by 心 猿 on 14-9-4.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
//封装一个瀑布流视图
#import <UIKit/UIKit.h>

@interface WaterFlowVC : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIView * mainView;//两个table的父视图
@property (nonatomic, strong) UIView * backgroundView;
@property (nonatomic, strong) UITableView * leftTableView;
@property (nonatomic, strong) UITableView * rightTableView;
@property (nonatomic, strong) NSMutableArray * dataArr_left;//数据源，从外面传入数据进来
@property (nonatomic, strong) NSMutableArray * dataArr_right;
@property (nonatomic, strong) NSMutableArray * dataArr_all;//把dadaArr_all一分为二给dataArr_left和dataArr_right
@property (nonatomic, copy) NSString * titleStr;
@property (nonatomic, assign)CGFloat height;
@property (nonatomic, strong) NSDictionary * loginDict;
@property (nonatomic, assign) int isButtom;//是否有下一页，如果没有就是1
@end
