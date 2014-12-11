//
//  RemarkTableView.h
//  if_wapeng
//
//  Created by 心 猿 on 14-9-15.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RemarkTableView : UITableView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray * dataArray;

@end
