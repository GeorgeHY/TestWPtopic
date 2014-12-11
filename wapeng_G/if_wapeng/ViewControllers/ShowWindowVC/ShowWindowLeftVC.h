//
//  ShowWindowLeftVC.h
//  if_wapeng
//
//  Created by 心 猿 on 14-8-11.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowWindowLeftVC : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray * dataArray;
}
@property (nonatomic, strong) UITableView * tableView;
@end
