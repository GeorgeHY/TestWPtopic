//
//  MyMail.h
//  if_wapeng
//
//  Created by 早上好 on 14-10-22.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshTableView.h"

@interface MyMail : UIView<UITableViewDataSource , UITableViewDelegate>
@property(nonatomic , strong) RefreshTableView * tableView;
@property(nonatomic , strong) NSMutableArray * dataSource;
-(void)setLoadData:(NSMutableArray *)dataSource;

-(void)stopRefreshingTableview;

@end
