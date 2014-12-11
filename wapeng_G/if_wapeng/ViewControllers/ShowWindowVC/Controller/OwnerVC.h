//
//  OwnerVC.h
//  if_wapeng
//
//  Created by 心 猿 on 14-11-12.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"
@interface OwnerVC : UIViewController<UITableViewDataSource, UITableViewDelegate, RTLabelDelegate>
{
    NSMutableArray * _dataArray;
}
@property (nonatomic, assign) int pageType;//页面类型

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray * dataArray;//瞬间列表
@property (nonatomic, strong) NSMutableDictionary * momentDict;//瞬间评论列表的字典，以瞬间id作为key
@property (nonatomic, strong) NSMutableDictionary * zanDict;//赞列表的字典,以瞬间的id作为key

@property (nonatomic, assign) int userType;

@end
