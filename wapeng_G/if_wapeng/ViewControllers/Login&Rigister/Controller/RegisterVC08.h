//
//  RegisterVC08.h
//  if_wapeng
//
//  Created by 心 猿 on 14-8-27.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterVC08 : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    NSMutableArray * dataArray;
    UITableView * _tableView;
}
@property(nonatomic,strong)NSString * _id;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong) NSMutableArray * dataArray;
@end