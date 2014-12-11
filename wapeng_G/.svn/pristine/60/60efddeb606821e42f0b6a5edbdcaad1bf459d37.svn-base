//
//  MyTalkView.h
//  if_wapeng
//
//  Created by 早上好 on 14-9-16.
//  Copyright (c) 2014年 funeral. All rights reserved.
//headerRereshing{

//footerRereshing
typedef void  (^HeaderRereshBlock)(void);
typedef void  (^FooterAddBlock)(void);
#import <UIKit/UIKit.h>

@interface MyTalkView : UIView<UITableViewDataSource , UITableViewDelegate>
@property(nonatomic , strong) UITableView * tableView;
@property(nonatomic , strong) NSMutableArray * dataSource;
@property(nonatomic , copy) HeaderRereshBlock headerBlock;
@property(nonatomic , copy) FooterAddBlock footerBlock;
-(void)reloadTableData;

-(void)setTableViewData:(NSMutableArray * )dataSource;
- (void)setupRefresh;
- (void)stopRefresh;
//-(void) createComponent;
@end
