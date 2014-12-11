//
//  SellerAcitvityVC.h
//  if_wapeng
//
//  Created by 心 猿 on 14-8-7.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SellerAcitvityVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    //数据源
    NSMutableArray * dataArray;
    
    UISearchBar * search;
    
    //保存搜索结果的数组
    NSMutableArray * resultArray;
}
@property (nonatomic, strong) UITableView * tableView;

@end
