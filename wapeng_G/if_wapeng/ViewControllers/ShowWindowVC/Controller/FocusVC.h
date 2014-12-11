//
//  FocusVC.h
//  if_wapeng
//
//  Created by 心 猿 on 14-11-13.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FocusVC : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    
}
@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, assign) int type; //1用户的粉丝列表  2用户的关注人列表

@property (nonatomic, strong) NSString * authorID;
@end
