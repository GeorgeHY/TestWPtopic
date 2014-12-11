//
//  ActivityDetailVC.m
//  if_wapeng
//
//  Created by 心 猿 on 14-8-7.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "ActivityDetailVC.h"

@interface ActivityDetailVC ()
{
}
@end

@implementation ActivityDetailVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    
        
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
     self.title = @"活动详情";
    
    dataArray = [[NSMutableArray alloc]init];
    
    if (IOS7) {
        self.navigationController.navigationBar.translucent = NO;
    }
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - 64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

@end
