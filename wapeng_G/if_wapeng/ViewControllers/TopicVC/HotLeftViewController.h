//
//  HotLeftViewController.h
//  if_wapeng
//
//  Created by 心 猿 on 14-8-8.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotLeftViewController : UIViewController<UITableViewDataSource , UITableViewDelegate>
@property(nonatomic , retain) UITableView * tableView;
@property(nonatomic , retain) NSMutableArray * dateSource;
@property(nonatomic , retain) UIImageView * headIm;
@property(nonatomic , retain) UILabel * name;
@end
