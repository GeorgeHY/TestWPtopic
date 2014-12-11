//
//  KindergartenVC.h
//  if_wapeng
//
//  Created by 心 猿 on 14-12-2.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KindergartenVC : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, strong) UITableView * tableVeiw;
@end
