//
//  RefreshTableView.m
//  if_wapeng
//
//  Created by 早上好 on 14-10-21.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "RefreshTableView.h"

@implementation RefreshTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.separatorStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = kRGB(237, 237, 237);
    }
    return self;
}
-(void)addTableRefreshView{
    //#warning 自动刷新(一进入程序就下拉刷新)
    [self headerBeginRefreshing];
}
/**设置请求参数**/
- (void)setupRefresh;
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self addHeaderWithTarget:self action:@selector(headerRereshing)];
    //#warning 自动刷新(一进入程序就下拉刷新)
//    [self headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.headerPullToRefreshText = @"下拉刷新数据";
    self.headerReleaseToRefreshText = @"松开刷新数据";
    self.headerRefreshingText = @"正在刷新数据，请稍等";
    
    self.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.footerRefreshingText = @"正在加载数据，请稍等";
}
/**上拉刷新**/
-(void)headerRereshing{
    self.headerBlock();
}
/**下拉加载**/
-(void)footerRereshing{
    self.footBlock();
}



@end
