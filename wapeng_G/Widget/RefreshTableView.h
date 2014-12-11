//
//  RefreshTableView.h
//  if_wapeng
//
//  Created by 早上好 on 14-10-21.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+MJRefresh.h"
#import "TableViewRefresh.h"
@interface RefreshTableView : UITableView
- (void)setupRefresh;
-(void)addTableRefreshView;
@property(nonatomic , copy) HeaderRereshBlock headerBlock;
@property(nonatomic , copy) FooterAddBlock footBlock;
@end
