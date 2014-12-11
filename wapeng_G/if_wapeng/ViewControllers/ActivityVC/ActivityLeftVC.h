//
//  ActivityLeftVC.h
//  if_wapeng
//
//  Created by 心 猿 on 14-8-7.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityLeftVC : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSArray * nameArray;
}
@property (nonatomic, strong) UITableView * tableView;
@end
