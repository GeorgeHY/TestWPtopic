//
//  SearchResultVC.h
//  if_wapeng
//
//  Created by 心 猿 on 14-9-2.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotWordVIew.h"
@interface SearchResultVC : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate,HotWordDelegate>
{
    AFN_HttpBase * http;
    NSMutableArray * _dataArray;
    UITableView * _tableView;
}
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong)UISearchBar * search;
@property (nonatomic, strong)NSString * ddid;
@property (nonatomic, assign) int pageType;//界面类型
@property (nonatomic, assign) NSInteger age;//同龄活动的年龄段
@property (nonatomic, strong) NSString * searchText;
@property (nonatomic, strong) NSMutableArray * lblTextArr;//个性标签的数组
@end
