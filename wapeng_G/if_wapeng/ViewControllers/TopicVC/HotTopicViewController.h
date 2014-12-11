//
//  HotTopicViewController.h
//  if_wapeng
//
//  Created by 心 猿 on 14-8-7.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotTopicViewController : UIViewController<UITableViewDataSource , UITableViewDelegate ,UISearchBarDelegate>

@property(nonatomic , retain) UIButton * leftBtn;
@property(nonatomic , retain) UIButton * rightBtn;
@property(nonatomic , retain) UISearchBar * searchBar;
@property(nonatomic , retain) UIScrollView * scroll;
@property(nonatomic , retain) UITableView * tableView;
@property(nonatomic , retain) NSMutableArray * dateSource;
@end
