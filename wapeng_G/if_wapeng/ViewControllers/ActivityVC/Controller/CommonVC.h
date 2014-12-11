//
//  CommonVC.h
//  if_wapeng
//
//  Created by 心 猿 on 14-9-11.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotWordVIew.h"
@interface CommonVC : UIViewController<UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate,HotWordDelegate>
{
}
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, assign) int pageType;//1代表今日十大
@property (nonatomic, strong) NSMutableArray * arr_data;
@end
