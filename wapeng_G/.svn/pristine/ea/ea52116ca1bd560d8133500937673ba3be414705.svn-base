//
//  AllActivityVC.h
//  if_wapeng
//
//  Created by 心 猿 on 14-8-29.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
typedef enum {
    allACtivity,//全部活动
    searchResult//搜索结果
}VCType;
/*全部活动视图控制器，也是搜索结果视图控制器*/
#import <UIKit/UIKit.h>
#import "WaterFlowVC.h"
@interface AllActivityVC : UIViewController<UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate, UISearchBarDelegate>
{
    NSMutableArray * _dataArray;
    UITableView * _tableView;
}
@property (nonatomic, strong) UISearchBar * searchBar;

@property (nonatomic, strong) WaterFlowVC * wateflowVC;//瀑布流视图控制器
@property (nonatomic, assign) VCType vcType;//0全部活动1,搜索结果
@end
